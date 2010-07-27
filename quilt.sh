        NAME=quilt
     VERSION=0.48
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://download.savannah.gnu.org/releases/${NAME}
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
./configure --prefix=$PREFIX
make
make install
