        NAME=numexpr
     VERSION=1.3.1
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://$(NAME).googlecode.com/files
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="python -c 'import numexpr'"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
