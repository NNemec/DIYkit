set -e # exit shell on errors

case "$0" in
*.diy) ;;
*)
    echo "DIYkit-include.sh should only included by .diy installation scripts"
    exit 1
esac

if [ -z "$DIYkit" ] ; then
    echo "DIYkit installation scripts should only be called via"
    echo "    diy install <pkg>"
    exit 1
fi

PREFIX=$DIYkit
SRCDIR=$DIYkit/src/$NAME
BINDIR=$DIYkit/bin
DOCDIR=$DIYkit/doc
TMPDIR=$DIYkit/tmp
DOWNLOADDIR=$DIYkit/download

INSTALLED=unknown
[ -n "$FIND_INSTALLED" ] && INSTALLED=`sh -c "$FIND_INSTALLED" 2> /dev/null || true`

if [ -n "$DIY_GET" ] ; then
    echo ${!DIY_GET}
    exit 0
fi

if [ -n "$INSTALLED" ] ; then
    echo "DIYkit: found $NAME installed (version: $INSTALLED)"
    [ -n "$DIY_DEPEND" ] && exit 0
fi

function DEPENDS_ON() {(
    PKG="$1" ; VERSION="$2"
    [ "$PKG" != "$NAME" -a -z "$VERSION" ] && VERSION=any
    DIY_DEPEND=$VERSION bash $DIYkit/$PKG.diy
    unset PKG VERSION
)}

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
    curl -L $ARCHIVE_URL -o $TMPDIR/$DISTFILE
    if [ ! -s $TMPDIR/$DISTFILE ] ; then
        echo "DIYkit: Download unsuccessful! (file not found or empty)"
        echo URL: $ARCHIVE_URL
        echo Filename: $DISTFILE
        exit 1
    fi
#    case `file $TMPDIR/$DISTFILE` in
#    *gzip\ compressed\ data*)
#        ;;
#    *bzip2\ compressed\ data*)
#        ;;
#    *Zip\ archive\ data*)
#        ;;
#    *data\ or\ International\ Language\ text*)
#	;;
#    *)
#        echo "DIYkit: Download unsuccessful! (filetype not recognized)"
#        file $TMPDIR/$DISTFILE
#        exit 1
#        ;;
#    esac
    mv $TMPDIR/$DISTFILE .
    echo "... done downloading."
)}

function UNPACK_ARCHIVE() {(
    if [ -d $SRCDIR ] ; then
        echo "Keeping existing directory $SRCDIR -- remove to unpack freshly."
        return
    fi
    echo "DIYkit: unpacking archive $DISTFILE ..."
    mkdir -p $TMPDIR
    cd $TMPDIR
    rm -rf ./$NAME
    mkdir ./$NAME
    cd ./$NAME
    case $DISTFILE in
    *.tar.gz|*.tgz)
        gzip -c -d $DOWNLOADDIR/$DISTFILE | tar xf -
        ;;
    *.tar.bz2)
        bzcat $DOWNLOADDIR/$DISTFILE | tar xf -
        ;;
    *.zip)
        unzip $DOWNLOADDIR/$DISTFILE
        ;;
    *)
        echo "Unknown archive format"
        ;;
    esac
    mkdir -p $DIYkit/src
    rm -rf $SRCDIR
    mv ./* $SRCDIR
    cd ..
    rmdir ./$NAME
    echo "... done unpacking."
    if [ -f $DIYkit/patches/$NAME/series ] ; then
        cd $SRCDIR
        if quilt --version > /dev/null 2>&1 ; then
            echo "DIYkit: applying patches (quilt)"
            ln -sf $DIYkit/patches/$NAME ./patches
            quilt push -a
        else
            echo "DIYkit: applying patches (patch)"
            for p in $(cat $DIYkit/patches/$NAME/series) ; do
                patch -p 1 < $DIYkit/patches/$NAME/$p
            done
        fi
    fi
)}

function GIT_CLONE() {(
    DEPENDS_ON git

    GIT_URL=$1
    cd $DIYkit/src
    if [ -d $NAME/.git/ ] ; then
        cd $NAME
        git pull
    else
        rm -rf $NAME
        git clone $GIT_URL $NAME
    fi
)}

function HG_CLONE() {(
    DEPENDS_ON mercurial

    HG_URL=$1
    cd $DIYkit/src
    if [ -d $NAME/.hg/ ] ; then
        cd $NAME
        hg update
    else
        rm -rf $NAME
        hg clone $HG_URL $NAME
    fi
)}

function VERCMP() {
# thanks to http://rubinium.org/blog/archives/2010/04/05/shell-script-version-compare-vercmp/
    expr '(' "$1" : '\([^.]*\)' ')' '-' '(' "$2" : '\([^.]*\)' ')' '|' \
         '(' "$1" : '[^.]*[.]\([^.]*\)' ')' '-' '(' "$2" : '[^.]*[.]\([^.]*\)' ')' '|' \
         '(' "$1" : '[^.]*[.][^.]*[.]\([^.]*\)' ')' '-' '(' "$2" : '[^.]*[.][^.]*[.]\([^.]*\)' ')' '|' \
         '(' "$1" : '[^.]*[.][^.]*[.][^.]*[.]\([^.]*\)' ')' '-' '(' "$2" : '[^.]*[.][^.]*[.][^.]*[.]\([^.]*\)' ')'
}

# DEPENDS_ON curl
# DEPENDS_ON pkg-config # at least 0.20 ??