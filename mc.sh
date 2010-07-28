        NAME=mc
     VERSION=4.7.0.7
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://www.midnight-commander.org/downloads
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="mc -V"

. $NNlab_path/NNlab-include.sh

NNlab depend slang

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
./configure --prefix $PREFIX
make
make install
