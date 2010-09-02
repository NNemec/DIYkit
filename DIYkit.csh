if ( ! $?DIYkit ) setenv DIYkit ~/.DIYkit

if ( ! $?PATH ) set PATH=""
if ( ! $?MANPATH ) set MANPATH=""
if ( ! $?CPATH ) set CPATH=""
if ( ! $?LIBRARY_PATH ) set LIBRARY_PATH=""
if ( ! $?LD_LIBRARY_PATH ) set LD_LIBRARY_PATH=""
if ( ! $?PKG_CONFIG_PATH ) set PKG_CONFIG_PATH=""

setenv PATH $DIYkit/bin:$PATH
setenv MANPATH $DIYkit/man:$MANPATH
setenv MANPATH $DIYkit/share/man:$MANPATH
setenv CPATH $DIYkit/include:$CPATH
setenv LIBRARY_PATH $DIYkit/lib:$LIBRARY_PATH
setenv LD_LIBRARY_PATH $DIYkit/lib:$LD_LIBRARY_PATH
setenv PKG_CONFIG_PATH $DIYkit/lib/pkgconfig:$PKG_CONFIG_PATH
setenv PYTHONUSERBASE $DIYkit

# for f in $DIYkit/DIYkit.sh.d/*.sh ; do
#     [ -f $f ] && . $f
# done

alias diy $DIYkit/DIYkit
