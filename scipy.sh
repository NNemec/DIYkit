        NAME=scipy
     VERSION=0.8.0
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://downloads.sourceforge.net/project/scipy/scipy/${VERSION}
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="python -d 'import scipy'"

. $NNlab_path/NNlab-include.sh

NNlab depend numpy

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
export LDFLAGS=-shared
python setup.py config
python setup.py build
python setup.py install --prefix $PREFIX
