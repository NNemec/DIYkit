if ( ! $?DIYkit ) setenv DIYkit ~/.DIYkit

if ( ! $?PATH ) setenv PATH ""
if ( ! $?MANPATH ) setenv MANPATH ""
if ( ! $?CPATH ) setenv CPATH ""
if ( ! $?LIBRARY_PATH ) setenv LIBRARY_PATH ""
if ( ! $?LD_LIBRARY_PATH ) setenv LD_LIBRARY_PATH ""
if ( ! $?PKG_CONFIG_PATH ) setenv PKG_CONFIG_PATH ""

setenv PATH $DIYkit/bin:$PATH
setenv MANPATH $DIYkit/man:$MANPATH
setenv MANPATH $DIYkit/share/man:$MANPATH
setenv CPATH $DIYkit/include:$CPATH
setenv LIBRARY_PATH $DIYkit/lib:$LIBRARY_PATH
setenv LD_LIBRARY_PATH $DIYkit/lib:$LD_LIBRARY_PATH
setenv PKG_CONFIG_PATH $DIYkit/lib/pkgconfig:$PKG_CONFIG_PATH
setenv PYTHONUSERBASE $DIYkit

foreach f ( $DIYkit/DIYkit.csh.d/*.csh )
    if ( -f $f ) source $f
end

alias diy $DIYkit/DIYkit
