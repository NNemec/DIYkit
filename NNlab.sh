export NNlab_path=~/NNlab
if [ -e ~/local/NNlab ] ; then
    export NNlab_path=~/local/NNlab
fi

PATH_PREPEND() {
    if [ -z "$1" ] ; then
        echo $2
    else
        echo $2`echo :$1 | sed "s#:$2##g"`
    fi
}

export PATH=`PATH_PREPEND "$PATH" $NNlab_path/bin`
export CPATH=`PATH_PREPEND "$CPATH" $NNlab_path/include`
export LIBRARYPATH=`PATH_PREPEND "$LIBRARYPATH" $NNlab_path/lib`
export LD_LIBRARY_PATH=`PATH_PREPEND "$LD_LIBRARY_PATH" $NNlab_path/lib`
export PYTHONPATH=`PATH_PREPEND "$PYTHONPATH" $NNlab_path/lib/python2.6/site-packages`
export PKG_CONFIG_PATH=`PATH_PREPEND "$PKG_CONFIG_PATH" $NNlab_path/lib/pkgconfig`

unset LIB PATH_PREPEND

####################

#export GUILE_LOAD_PATH=$NNlab_path/share/guile/1.8
#export GPAW_SETUP_PATH=$NNlab_path/data/gpaw-setups
