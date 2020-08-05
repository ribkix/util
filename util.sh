#!/bin/bash

if [[ $1 =  "executable" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            cp $2 ${2%%.*}
            ls -l ${2%%.*}
            chmod u+x ${2%%.*}
            ls -l ${2%%.*}
            chmod a+x ${2%%.*}
            ls -l ${2%%.*}
            mv ${2%%.*} /usr/local/games/${2%%.*}
            echo "Done, run \"${2%%.*}\""
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify the file you want to make executable."
    fi
elif [[ $1 = "copy" ]]; then
    if [[ $# = 3 ]]; then
        cp $2 $3
    else
        echo "Please specify the file you want to copy and the destination you want to paste."
    fi
elif [[ $1 = "move" ]]; then
    if [[ $# = 3 ]]; then
        mv $2 $3
    else
        echo "Please specify the file you want to move and the destination you want to move it to."
    fi
elif [[ $1 = "new" ]]; then
    if [[ $# = 2 ]]; then
        nf $2
    elif [[ $# = 3 ]]; then
        $3 $2
    else
        echo "Please specify the file you want to create."
    fi
elif [[ $1 = "install" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            apt-get install $2 || dnf install $2 || pacman -S $2
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to install."
    fi
elif [[ $1 = "list" ]]; then
    apt list || dnf list || echo "This command isn't supported in your distro."
elif [[ $1 = "remove" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            apt remove $2 || dnf remove $2 || pacman -Rsc $2
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to remove."
    fi
elif [[ $1 = "update" ]]; then
    if [[ $EUID = 0 ]]; then
        apt update || dnf updateinfo || echo "This command isn't supported in your distro."
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "search" ]]; then
    if [[ $# = 2 ]]; then
        apt search $2 || dnf search $2 || pacman -Ss $2
    else
        echo "Please specify what you want to search."
    fi
elif [[ $1 = "show" ]]; then
    if [[ $# = 2 ]]; then
        apt show $2 || dnf info $2 || pacman -Qii $2
    else
        echo "Please specify what you want to show."
    fi
elif [[ $1 = "reinstall" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            apt reinstall $2 || dnf reinstall $2 || echo "This command isn't supported in your distro."
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to reinstall."
    fi
elif [[ $1 = "autoremove" ]]; then
    if [[ $EUID = 0 ]]; then
        apt autoremove || dnf autoremove || pacman -Rns
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "upgrade" ]]; then
    if [[ $EUID = 0 ]]; then
        apt upgrade || dnf upgrade || pacman -Syu
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "s-install" ]]; then
    if [[ $# = 2 ]]; then
        sudo apt-get install $2 || sudo dnf install $2 || sudo pacman -S $2
    else
        echo "Please specify what you want to install."
    fi
elif [[ $1 = "s-remove" ]]; then
    if [[ $# = 2 ]]; then
        sudo apt remove $2 || sudo dnf remove $2 || sudo pacman -Rsc $2
    else
        echo "Please specify what you want to remove."
    fi
elif [[ $1 = "s-update" ]]; then
    sudo apt update || sudo dnf updateinfo || echo "This command isn't supported in your distro."
elif [[ $1 = "s-reinstall" ]]; then
    if [[ $# = 2 ]]; then
        sudo apt reinstall $2 || sudo dnf reinstall $2 || echo "This command isn't supported in your distro."
    else
        echo "Please specify what you want to reinstall."
    fi
elif [[ $1 = "s-autoremove" ]]; then
    sudo apt autoremove || sudo dnf autoremove || sudo pacman -Rns
elif [[ $1 = "s-upgrade" ]]; then
    sudo apt upgrade || sudo dnf upgrade || sudo pacman -Syu
elif [[ $1 = "root" ]]; then
    su
elif [[ $1 = "create-root" ]]; then
    sudo passwd root
elif [[ $1 = "deb" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            dpkg -i $2
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify the .deb file you want to install."
    fi
elif [[ $1 = "s-deb" ]]; then
    if [[ $# = 2 ]]; then
        sudo dpkg -i $2
    else
        echo "Please specify the .deb file you want to install."
    fi
elif [[ $1 = "del" ]]; then
    if [[ $# = 2 ]]; then
        rm $2
    else
        echo "Please specify the file you want to delete."
    fi
elif [[ $1 =  "refresh" ]]; then
    if [[ $EUID = 0 ]]; then
        cp util.sh util
        ls -l util
        chmod u+x util
        ls -l util
        chmod a+x util
        ls -l util
        mv util /usr/local/games/util
        echo "Done"
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "help" ]]; then
    echo "[] - optional argument"
    echo "<> - required argument"
    # echo "<thing1 | thing2> - select one of these options"
    echo "[S] - possible to add \"s-\" before the command to run without root, for example: util s-install"
    echo ""
    echo "FILES"
    echo ""
    echo "util copy <file to copy> <destination to paste> - copies and pastes a file"
    echo "util move <file to move> <destination to move it to> - moves a file"
    echo "util new <file name> [editor] - makes a new file"
    echo "util del <file name> - deletes a file"
    echo ""
    echo "PACKAGES"
    echo ""
    echo "[S] util install <package> - installs what package you specified (root required)"
    echo "util list - shows lists of packages you can install"
    echo "[S] util remove <package> - removes what you specified (root required)"
    echo "[S] util update - updates list of available packages (root required)"
    echo "util search <package> - searches the package you specified"
    echo "util show <package> - shows the package you specified"
    echo "[S] util reinstall <package> - reinstalls what package you specified (root required)"
    echo "[S] util autoremove - automatically removes all unused packages (root required)"
    echo "[S] util upgrade - upgrades the system by installing/upgrading packages (root required)"
    echo ""
    echo "MISCELLANEOUS"
    echo ""
    echo "util executable <file> - makes the specified file an executable (root required)"
    echo "util root - login to root"
    echo "util create-root - create root"
    echo "[S] util deb <.deb file> - install deb file (root required)"
    echo "util refresh - updates util with new code in the .sh file"
else
    echo "Invalid command \"$1\""
    echo "Try running \"util help\""
fi
