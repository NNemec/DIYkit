if [ -z "$NAME" ] ; then
    echo "NNlab-include.sh should only included by NNlab installation scripts"
    echo "(variable \$NAME not defined)"
    exit 1
fi

if $DEPENDENCY_ONLY && [ -n "$AVAILABLE" ] && $AVAILABLE ; then
    echo "NNlab: found $NAME installed"
    exit 0
fi

if [ -z "$NNlab_path" ] ; then
    NNlab_path=$HOME/NNlab
fi

PREFIX=$NNlab_path
SRCDIR=$NNlab_path/src
BINDIR=$NNlab_path/bin
DOCDIR=$NNlab_path/doc
TMPDIR=$NNlab_path/tmp
DOWNLOADDIR=$NNlab_path/download

function DOWNLOAD_ARCHIVE() {(
    mkdir -p $DOWNLOADDIR
    cd $DOWNLOADDIR
    if [ -s $DISTFILE ] ; then
        echo "Found $DOWNLOADDIR/$DISTFILE -- do not download again"
    else
        mkdir -p $TMPDIR
        rm -f $TMPDIR/$DISTFILE
        ( cd $TMPDIR ; wget $ARCHIVE_URL )
    fi
    if [ ! -s $TMPDIR/$DISTFILE ] ; then
        echo Download unsuccessful!
        echo URL: $ARCHIVE_URL
        echo Filename: $DISTFILE
        exit 1
    fi
    case `file -i $TMPDIR/$DISTFILE` in
    *application/x-gzip*)
        ;;
    *application/x-bzip2*)
        ;;
    *)
        echo "Download unsuccessful (filetype not recognized)"
        file -i $TMPDIR/$DISTFILE
        exit 1
        ;;
    esac
    mv $TMPDIR/$DISTFILE .
)}

function UNPACK_ARCHIVE() {(
    mkdir -p $TMPDIR
    cd $TMPDIR
    rm -rf ./$NAME
    mkdir ./$NAME
    cd ./$NAME
    case $DISTFILE in
    *.tar.gz)
        tar xfz $DOWNLOADDIR/$DISTFILE
        ;;
    *.tar.bz2)
        tar xfj $DOWNLOADDIR/$DISTFILE
        ;;
    *)
        echo "Unknown archive format"
        ;;
    esac
    mkdir -p $SRCDIR
    rm -rf $SRCDIR/$NAME
    mv ./* $SRCDIR/$NAME
    cd ..
    rmdir ./$NAME
)}

function APPLY_PATCH() {(
    cd $SRCDIR
    ln -sf $NNlab_patch/patches/$NAME patches
    quilt push -a
)}

export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

function INSTALL {(
    echo NNlab: Installing dependency $1
    $NNlab_path/NNlab install $1
)}
