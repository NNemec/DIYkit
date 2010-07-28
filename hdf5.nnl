        NAME=hdf5
     VERSION=1.8.5
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://www.hdfgroup.org/ftp/HDF5/current/src
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="pkg-config --exists template"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

######### autoconf
cd $SRCDIR/$NAME
./configure --prefix $PREFIX
make -C src install
make -C tools install
