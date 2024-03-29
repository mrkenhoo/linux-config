#!/bin/sh		

case "${LINUX_DISTRO}" in
    arch|archlinux)
        if test ! -d "kernels/linux-tkg"
        then
            git -C "kernels" clone "https://github.com/frogging-family/linux-tkg.git"

            if test -f "kernels/linux-tkg/customization.cfg"
            then
                test ${EDITOR} && ${EDITOR} "kernels/linux-tkg/customization.cfg" || exit 1
            fi

            cd "kernels/linux-tkg" && makepkg -si && cd "../.."
        else
            if test -f "kernels/linux-tkg/customization.cfg"
            then
                test ${EDITOR} && ${EDITOR} "kernels/linux-tkg/customization.cfg" || exit 1
            fi
            cd "kernels/linux-tkg" && git pull && makepkg -sif && cd "../.."
        fi
    ;;
    *)
        echo "error: ${LINUX_DISTRO}: distribution not supported"
	    exit 1
    ;;
esac
