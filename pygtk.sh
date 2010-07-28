        NAME=pygtk
     VERSION=2.10.4
    DISTFILE=${NAME}-${VERSION}.tar.gz
 MASTER_SITE=http://ftp.gnome.org/pub/GNOME/sources/pygtk/2.10
 ARCHIVE_URL=${MASTER_SITE}/${DISTFILE}
   AVAILABLE="python -c 'import pygtk'"

. $NNlab_path/NNlab-include.sh

DOWNLOAD_ARCHIVE
UNPACK_ARCHIVE
# PATCH_ARCHIVE

cd $SRCDIR/$NAME
CPPFLAGS="-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include" ./configure --prefix $PREFIX
make
make install
