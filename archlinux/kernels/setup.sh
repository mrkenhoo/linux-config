#!/bin/sh		

if test ! -d "kernels/linux-tkg"
then
    git -C "kernels" clone "https://github.com/frogging-family/linux-tkg.git"

    test ! $(command -v patch) && sudo pacman -Sy --needed --noconfirm "base-devel"

    if test -f "kernels/linux-tkg/customization.cfg"
    then
        test $EDITOR && $EDITOR "kernels/linux-tkg/customization.cfg" || exit 1
    fi

    cd "kernels/linux-tkg" && makepkg -cirs --needed && cd "../.."
else
    cd "kernels/linux-tkg" && git pull && makepkg -cirsf && cd "../.."
fi
