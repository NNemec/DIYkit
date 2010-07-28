[ -z "$NNlab_path" ] && export NNlab_path=~/NNlab

PATH_PREPEND() {
    echo -n $2
    [ -n "$1" ] && echo -n $(echo :$1 | sed "s#:$2##g")
    echo
}

export PATH=`PATH_PREPEND "$PATH" $NNlab_path/bin`
export CPATH=`PATH_PREPEND "$CPATH" $NNlab_path/include`
export LIBRARYPATH=`PATH_PREPEND "$LIBRARYPATH" $NNlab_path/lib`
export LD_LIBRARY_PATH=`PATH_PREPEND "$LD_LIBRARY_PATH" $NNlab_path/lib`
export PYTHONPATH=`PATH_PREPEND "$PYTHONPATH" $NNlab_path/lib/python2.6/site-packages`
export PKG_CONFIG_PATH=`PATH_PREPEND "$PKG_CONFIG_PATH" $NNlab_path/lib/pkgconfig`

unset PATH_PREPEND

alias NNlab=$NNlab_path/NNlab

####################

#export GUILE_LOAD_PATH=$NNlab_path/share/guile/1.8
#export GPAW_SETUP_PATH=$NNlab_path/data/gpaw-setups
