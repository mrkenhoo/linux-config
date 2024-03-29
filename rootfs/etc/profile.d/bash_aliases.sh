#!/bin/sh

# detailed file and directory listing
alias ll='ls -alBih --color=auto'
alias ls='ls --color=auto'

# apt-like pacman wrapper
pkg()
{
    if test -z $1
    then
        echo "Usage: $(basename $0) [install|update|upgrade|purge|search|clean]"
        return 1
    fi

    case "$1" in
        install) shift; sudo pacman -S --needed "$@"; return $?;;
        remove) shift; sudo pacman -Rsu "$@"; return $?;;
        update) shift; sudo pacman -Sy --needed; return $?;;
        upgrade) shift; sudo pacman -Syu --needed; return $?;;
        purge) shift; sudo pacman -Rncsd "$@"; return $?;;
        search) shift; pacman -Ss "$@"; return $?;;
        clean) shift; sudo pacman -Rncsd $(pacman -Qqtd); return $?;;
        *) test ! -z $1 && echo "error: $1: unknown command"; return $?;;
    esac

    return 1
}
