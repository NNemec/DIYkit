[ -z "$NNlab_path" ] && export NNlab_path=~/NNlab

PATH_REMOVE() {
    echo :$1 | sed "s#:$2##g" | cut -c 2-
}

export PATH=`PATH_REMOVE "$PATH" $NNlab_path/bin`
export CPATH=`PATH_REMOVE "$CPATH" $NNlab_path/include`
export LIBRARYPATH=`PATH_REMOVE "$LIBRARYPATH" $NNlab_path/lib`
export LD_LIBRARY_PATH=`PATH_REMOVE "$LD_LIBRARY_PATH" $NNlab_path/lib`
export PYTHONPATH=`PATH_REMOVE "$PYTHONPATH" $NNlab_path/lib/python2.6/site-packages`
export PKG_CONFIG_PATH=`PATH_REMOVE "$PKG_CONFIG_PATH" $NNlab_path/lib/pkgconfig`

unset PATH_REMOVE NNlab NNlab_path
