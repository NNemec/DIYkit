        NAME=numpy
     VERSION=1.4.1
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://downloads.sourceforge.net/project/numpy/NumPy/1.4.1
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="python -d 'import numpy'"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
export LDFLAGS=-shared
export MKL=None
python setup.py build
python setup.py install --prefix $PREFIX
