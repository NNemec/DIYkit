export NNlab_path=~/NNlab
if [ -e ~/local/NNlab ] ; then
    export NNlab_path=~/local/NNlab
fi

if [ `uname -m` == "x86_64" ] ; then
    LIB=lib64
else
    LIB=lib
fi

export NNlab_home=http://www.tcm.phy.cam.ac.uk/~nn245/NNlab

export PATH=`echo $PATH | sed "s/\.://g;s&$NNlab_path/[^:]*:&&g"`
export PATH=$NNlab_path/bin:$PATH
export PATH=.:$PATH

export PYTHONPATH=$NNlab_path/$LIB/python2.6/site-packages
#export CPATH=$NNlab_path/include
#export PKG_CONFIG_PATH=$NNlab_path/lib/pkgconfig
#export GUILE_LOAD_PATH=$NNlab_path/share/guile/1.8

if [ "$LD_LIBRARY_PATH" == "" ] ; then 
    export LD_LIBRARY_PATH="."
fi

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NNlab_path/$LIB"

export GPAW_SETUP_PATH=$NNlab_path/data/gpaw-setups
