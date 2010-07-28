        NAME=slang
     VERSION=2.2.2
    DISTFILE=${NAME}-${VERSION}.tar.bz2
 MASTER_SITE=ftp://space.mit.edu/pub/davis/slang/v2.2
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="pkg-config --exists slang"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
./configure --prefix $PREFIX
make
make install
