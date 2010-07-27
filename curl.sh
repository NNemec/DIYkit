        NAME=curl
     VERSION=7.21.0
    DISTFILE=${NAME}-${VERSION}.tar.bz2
 MASTER_SITE=http://curl.haxx.se/download
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
./configure --prefix $PREFIX
make
make install

#cd $DOCDIR/$NAME
#ln -s $SRCDIR/$NAME/doc ./$NAME
