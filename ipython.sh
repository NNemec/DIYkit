        NAME=ipython
     VERSION=0.10
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://ipython.scipy.org/dist/${VERSION}
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="pkg-config --exists template"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

######### autoconf
cd $SRCDIR/$NAME
./configure --prefix $PREFIX
make
make install

######### python
cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
