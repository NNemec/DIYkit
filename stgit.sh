        NAME=stgit
     VERSION=0.14.1
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://homepage.ntlworld.com/cmarinas/$(NAME)
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="stg -v"

. $NNlab_path/NNlab-include.sh

NNlab depend git

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
