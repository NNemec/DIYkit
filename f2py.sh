        NAME=f2py
     VERSION=2.45.241_1926
    DISTFILE=F2PY-$(VERSION).tar.gz
 MASTER_SITE=http://cens.ioc.ee/projects/f2py2e/2.x
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="f2py -v"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
python setup.py build
python setup.py install --prefix $PREFIX
