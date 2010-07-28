        NAME=cython
     VERSION=0.12.1
    DISTFILE=Cython-${VERSION}.tar.gz
 MASTER_SITE=http://cython.org/release
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="cython --version"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
