        NAME=template
     VERSION=1.0
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://someserver.com/download
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="pkg-config --exists template"

. $NNlab_path/NNlab-include.sh

NNlab depend somepkg

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
