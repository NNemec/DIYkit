set -e # exit shell on errors

case "$0" in
*.diy) ;;
*)
    echo "DIYkit-include.sh should only included by .diy installation scripts"
    exit 1
fi

[ -z "$DIYkit" ] && export DIYkit=~/DIYkit
. $DIYkit/DIYkit.sh

if [ -n "$DEPENDENCY_ONLY" ] && [ -n "$AVAILABLE" ] && sh -c "$AVAILABLE" ; then
    echo "DIYkit: found $NAME installed"
    exit 0
fi

PREFIX=$DIYkit
SRCDIR=$DIYkit/src
BINDIR=$DIYkit/bin
DOCDIR=$DIYkit/doc
TMPDIR=$DIYkit/tmp
DOWNLOADDIR=$DIYkit/download

function DOWNLOAD_ARCHIVE() {(
    mkdir -p $DOWNLOADDIR
    cd $DOWNLOADDIR
    if [ -s $DISTFILE ] ; then
        echo "Found $DOWNLOADDIR/$DISTFILE -- do not download again"
        return
    fi
    echo "DIYkit: downloading archive $DISTFILE (from $ARCHIVE_URL) ..."
    mkdir -p $TMPDIR
    rm -f $TMPDIR/$DISTFILE
    ( cd $TMPDIR ; wget $ARCHIVE_URL )
    if [ ! -s $TMPDIR/$DISTFILE ] ; then
        echo "DIYkit: Download unsuccessful! (file not found or empty)"
        echo URL: $ARCHIVE_URL
        echo Filename: $DISTFILE
        exit 1
    fi
    case `file -i $TMPDIR/$DISTFILE` in
    *application/x-gzip*)
        ;;
    *application/x-bzip2*)
        ;;
    *application/zip*)
        ;;
    *)
        echo "DIYkit: Download unsuccessful! (filetype not recognized)"
        file -i $TMPDIR/$DISTFILE
        exit 1
        ;;
    esac
    mv $TMPDIR/$DISTFILE .
    echo "... done downloading."
)}

function UNPACK_ARCHIVE() {(
    echo "DIYkit: unpacking archive $DISTFILE ..."
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
    *.zip)
        unzip $DOWNLOADDIR/$DISTFILE
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
    if [ -f $DIYkit/patches/$NAME/series ] ; then
        echo "DIYkit: applying patches"
        cd $SRCDIR/$NAME
        ln -sf $DIYkit/patches/$NAME ./patches
        quilt push -a
    fi
)}

function GIT_CLONE() {(
    GIT_URL=$1
    cd $SRCDIR
    if [ -d $NAME/.git/ ] ; then
        cd $NAME
        git pull
    else
        rm -rf $NAME
        git clone $GIT_URL $NAME
    fi
)}
