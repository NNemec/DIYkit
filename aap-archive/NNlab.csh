setenv NNlab_path ~/NNlab
if ( -e ~/local/NNlab ) then
    setenv NNlab_path ~/local/NNlab
endif

if ( `uname -m` == "x86_64" ) ; then
    setenv LIB lib64
else
    setenv LIB lib
fi

set path = ( . $NNlab_path/bin `echo $path | sed "s&\. &&;s&$NNlab_path/bin &&"` )

setenv PYTHONPATH $NNlab_path/$LIB/python2.6
# setenv CPATH $NNlab_path/include
# setenv PKG_CONFIG_PATH $NNlab_path/lib/pkgconfig
# setenv GUILE_LOAD_PATH $NNlab_path/share/guile/1.8

if ( $?LD_LIBRARY_PATH ) then
    setenv LD_LIBRARY_PATH ".:$NNlab_path/lib:${LD_LIBRARY_PATH}"
else
    setenv LD_LIBRARY_PATH ".:$NNlab_path/lib"
endif

setenv GPAW_SETUP_PATH $NNlab_path/data/gpaw-setups
