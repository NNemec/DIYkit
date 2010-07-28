set -e # exit shell on errors

if [ -z "$NAME" ] ; then
    echo "NNlab-include.sh should only included by NNlab installation scripts"
    echo "(variable \$NAME not defined)"
    exit 1
fi

[ -z "$NNlab_path" ] && NNlab_path=~/NNlab

function NNlab() { $NNlab_path/NNlab "$@"; }

if [ -n "$DEPENDENCY_ONLY" ] && [ -n "$AVAILABLE" ] && sh -c "$AVAILABLE" ; then
    echo "NNlab: found $NAME installed"
    exit 0
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
        return
    fi
    echo "NNlab: downloading archive $DISTFILE (from $ARCHIVE_URL) ..."
    mkdir -p $TMPDIR
    rm -f $TMPDIR/$DISTFILE
    ( cd $TMPDIR ; wget $ARCHIVE_URL )
    if [ ! -s $TMPDIR/$DISTFILE ] ; then
        echo "NNlab: Download unsuccessful! (file not found or empty)"
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
        echo "NNlab: Download unsuccessful! (filetype not recognized)"
        file -i $TMPDIR/$DISTFILE
        exit 1
        ;;
    esac
    mv $TMPDIR/$DISTFILE .
    echo "... done downloading."
)}

function UNPACK_ARCHIVE() {(
    echo "NNlab: unpacking archive $DISTFILE ..."
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
    echo "... done unpacking."
)}

function APPLY_PATCH() {(
    cd $SRCDIR
    ln -sf $NNlab_patch/patches/$NAME patches
    quilt push -a
)}

export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
