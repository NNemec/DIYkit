        NAME=pytables
     VERSION=2.2
    DISTFILE=tables-${VERSION}.tar.gz
 MASTER_SITE=http://www.pytables.org/download/stable
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="python -c 'import tables'"

. $NNlab_path/NNlab-include.sh

NNlab depend hdf5

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
