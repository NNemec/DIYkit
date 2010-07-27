        NAME=git
     VERSION=1.7.2
    DISTFILE=${NAME}-${VERSION}.tar.bz2
 MASTER_SITE=http://www.kernel.org/pub/software/scm/$(NAME)
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
./configure --without-openssl --prefix=$PREFIX --with-curl=$PREFIX
make
make install
