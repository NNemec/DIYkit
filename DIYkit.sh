[ -z "$DIYkit" ] && export DIYkit=~/.DIYkit

PATH_PREPEND() {
    echo -n $2
    [ -n "$1" ] && echo -n $(echo :$1: | sed "s#:$2:#:#g;s#:\$##")
    echo
}

export PATH=$(PATH_PREPEND "$PATH" $DIYkit/bin)
[ -z "$MANPATH" ] && export MANPATH="XXXplaceholderXXX" # if original MANPATH was unset, the new one should end on ':'
export MANPATH=$(PATH_PREPEND "$MANPATH" $DIYkit/man)
export MANPATH=$(PATH_PREPEND "$MANPATH" $DIYkit/share/man)
export MANPATH=$(echo "$MANPATH" | sed s/XXXplaceholderXXX//)
export CPATH=$(PATH_PREPEND "$CPATH" $DIYkit/include)
export LIBRARY_PATH=$(PATH_PREPEND "$LIBRARY_PATH" $DIYkit/lib)
export LD_LIBRARY_PATH=$(PATH_PREPEND "$LD_LIBRARY_PATH" $DIYkit/lib)
export PKG_CONFIG_PATH=$(PATH_PREPEND "$PKG_CONFIG_PATH" $DIYkit/lib/pkgconfig)
export PYTHONUSERBASE=$DIYkit

for f in $DIKkit/DIYkit.sh.d/*.sh ; do
    [ -f $f ] && . $f
done

unset PATH_PREPEND

function diy() {
    case "$1" in
    off) . $DIYkit/DIYkit-off.sh ;;
    *) $DIYkit/DIYkit "$@" ;;
    esac
}

_diy () {
    local cur cmds cmdOpts opt helpCmds optBase i

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    cmds='avail install off update'

    if [[ $COMP_CWORD -eq 1 ]] ; then
        COMPREPLY=( $( compgen -W "$cmds" -- $cur ) )
        return 0
    fi

    cmdOpts=
    case ${COMP_WORDS[1]} in
    install)
        pkgs=$( for x in $DIYkit/*.diy ; do basename $x .diy ; done )
        COMPREPLY=( $( compgen -W "$pkgs" -- $cur ) )
        return 0
        ;;
    esac
}
complete -F _diy diy
