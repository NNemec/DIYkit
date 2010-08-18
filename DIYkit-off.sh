[ -z "$DIYkit" ] && export DIYkit=~/.DIYkit

PATH_REMOVE() {
    echo :$1 | sed "s#:$2##g" | cut -c 2-
}

export PATH=`PATH_REMOVE "$PATH" $DIYkit/bin`
export MANPATH=`PATH_REMOVE "$MANPATH" $DIYkit/man`
export MANPATH=`PATH_REMOVE "$MANPATH" $DIYkit/share/man`
export CPATH=`PATH_REMOVE "$CPATH" $DIYkit/include`
export LIBRARYPATH=`PATH_REMOVE "$LIBRARYPATH" $DIYkit/lib`
export LD_LIBRARY_PATH=`PATH_REMOVE "$LD_LIBRARY_PATH" $DIYkit/lib`
export PYTHONPATH=`PATH_REMOVE "$PYTHONPATH" $DIYkit/lib/python2.6/site-packages`
export PKG_CONFIG_PATH=`PATH_REMOVE "$PKG_CONFIG_PATH" $DIYkit/lib/pkgconfig`

unset PATH_REMOVE DIYkit
