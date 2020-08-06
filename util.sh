#!/bin/bash

if [[ $1 = "changelog" ]]; then
    echo "=+= What's new in Version 2020.8.6 =+="
    echo ""
    echo "- A bit of polishing"
    echo "- Added plugins"
    echo "- Added getchangelog command"
    echo "- Got rid of the wget output"
    echo "- Added copycmd command"
    echo "- Added pastecmd command"
    echo "- Added geturl command"
    echo "- Added multiple argument support"
    echo "- Added website command (NEW WEBSITE!!!)"
    echo "- Bug fixes"
elif [[ $1 =  "executable" ]]; then
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
        > $2
    elif [[ $# = 3 ]]; then
        $3 $2
    else
        echo "Please specify the file you want to create."
    fi
elif [[ $1 = "install" ]]; then
    if [[ $# -ge 2 ]]; then
        if [[ $EUID = 0 ]]; then
            {
                echo "Trying apt..."
                apt-get install ${*:2}
            } || {
                echo "Failed apt, trying dnf..."  
                dnf install ${*:2} 
            } || {
                echo "Failed dnf, trying pacman..."  
                pacman -S ${*:2} 
            } || {
                echo "Command failed."
            }
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to install."
    fi
elif [[ $1 = "list" ]]; then
    {
        echo "Trying apt..."
        apt list
    } || {
        echo "Failed apt, trying dnf..."  
        dnf list
    } || {
        echo "Command failed."
    }
elif [[ $1 = "remove" ]]; then
    if [[ $# -ge 2 ]]; then
        if [[ $EUID = 0 ]]; then
            {
                echo "Trying apt..."
                apt remove ${*:2}
            } || {
                echo "Failed apt, trying dnf..."  
                dnf remove ${*:2} 
            } || {
                echo "Failed dnf, trying pacman..."  
                pacman -Rsc ${*:2} 
            } || {
                echo "Command failed."
            }
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to remove."
    fi
elif [[ $1 = "update" ]]; then
    if [[ $EUID = 0 ]]; then
        {
            echo "Trying apt..."
            apt update
        } || {
            echo "Failed apt, trying dnf..."  
            dnf updateinfo
        } || {
            echo "Command failed."
        }
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "search" ]]; then
    if [[ $# -ge 2 ]]; then
        {
            echo "Trying apt..."
            apt search ${*:2}
        } || {
            echo "Failed apt, trying dnf..."  
            dnf search ${*:2} 
        } || {
            echo "Failed dnf, trying pacman..."  
            pacman -Ss ${*:2} 
        } || {
            echo "Command failed."
        }
    else
        echo "Please specify what you want to search."
    fi
elif [[ $1 = "show" ]]; then
    if [[ $# -ge 2 ]]; then
        {
            echo "Trying apt..."
            apt show ${*:2}
        } || {
            echo "Failed apt, trying dnf..."  
            dnf info ${*:2} 
        } || {
            echo "Failed dnf, trying pacman..."  
            pacman -Qii ${*:2} 
        } || {
            echo "Command failed."
        }
    else
        echo "Please specify what you want to show."
    fi
elif [[ $1 = "reinstall" ]]; then
    if [[ $# -ge 2 ]]; then
        if [[ $EUID = 0 ]]; then
            {
                echo "Trying apt..."
                apt reinstall ${*:2}
            } || {
                echo "Failed apt, trying dnf..."  
                dnf reinstall ${*:2} 
            } || {
                echo "Command failed."
            }
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify what you want to reinstall."
    fi
elif [[ $1 = "autoremove" ]]; then
    if [[ $EUID = 0 ]]; then
        {
            echo "Trying apt..."
            apt autoremove
        } || {
            echo "Failed apt, trying dnf..."  
            dnf autoremove
        } || {
            echo "Failed dnf, trying pacman..."  
            pacman -Rns
        } || {
            echo "Command failed."
        }
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "upgrade" ]]; then
    if [[ $EUID = 0 ]]; then
        {
            echo "Trying apt..."
            apt upgrade
        } || {
            echo "Failed apt, trying dnf..."  
            dnf upgrade
        } || {
            echo "Failed dnf, trying pacman..."  
            pacman -Syu
        } || {
            echo "Command failed."
        }
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "s-install" ]]; then
    if [[ $# -ge 2 ]]; then
        {
            echo "Trying apt..."
            sudo apt-get install ${*:2}
        } || {
            echo "Failed apt, trying dnf..."  
            sudo dnf install ${*:2} 
        } || {
            echo "Failed dnf, trying pacman..."  
            sudo pacman -S ${*:2} 
        } || {
            echo "Command failed."
        }
    else
        echo "Please specify what you want to install."
    fi
elif [[ $1 = "s-remove" ]]; then
    if [[ $# -ge 2 ]]; then
        {
            echo "Trying apt..."
            sudo apt-get remove ${*:2}
        } || {
            echo "Failed apt, trying dnf..."  
            sudo dnf remove ${*:2} 
        } || {
            echo "Failed dnf, trying pacman..."  
            sudo pacman -Rsc ${*:2} 
        } || {
            echo "Command failed."
        }
    else
        echo "Please specify what you want to remove."
    fi
elif [[ $1 = "s-update" ]]; then
    {  
        echo "Trying apt..."
        sudo apt-get update
    } || {
        echo "Failed apt, trying dnf..."  
        sudo dnf updateinfo 
    } || {
        echo "Command failed."
    }
elif [[ $1 = "s-reinstall" ]]; then
    if [[ $# -ge 2 ]]; then
        {
            echo "Trying apt..."
            sudo apt-get reinstall ${*:2}
        } || {
            echo "Failed apt, trying dnf..."  
            sudo dnf reinstall ${*:2} 
        } || {
            echo "Command failed."
        }
    else
        echo "Please specify what you want to reinstall."
    fi
elif [[ $1 = "s-autoremove" ]]; then
    {
        echo "Trying apt..."
        sudo apt-get autoremove
    } || {
        echo "Failed apt, trying dnf..."  
        sudo dnf autoremove
    } || {
        echo "Failed dnf, trying pacman..."  
        sudo pacman -Rns
    } || {
        echo "Command failed."
    }
elif [[ $1 = "s-upgrade" ]]; then
    {
        echo "Trying apt..."
        sudo apt-get upgrade
    } || {
        echo "Failed apt, trying dnf..."  
        sudo dnf upgrade
    } || {
        echo "Failed dnf, trying pacman..."  
        sudo pacman -Syu
    } || {
        echo "Command failed."
    }
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
        if [[ -f $2 ]]; then
            rm $2
        elif [[ -d $2 ]]; then
            rmdir $2
        else
            echo "Passed argument isn't a file nor a directory."
        fi
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
elif [[ $1 = "getupdate" ]]; then
    if [[ $EUID = 0 ]]; then
        wget https://raw.githubusercontent.com/ribkix/util/master/util.sh -O util.sh > /dev/null 2>&1
        cp util.sh util
        ls -l util
        chmod u+x util
        ls -l util
        chmod a+x util
        ls -l util
        mv util /usr/local/games/util
        echo "Done"
        wget https://raw.githubusercontent.com/ribkix/util/master/changelog.txt -O util_changelog.txt > /dev/null 2>&1
        printf '%b\n' "$(cat util_changelog.txt)"
        rm util_changelog.txt
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "version" ]]; then
    echo "2020.8.6"
elif [[ $1 = "getversion" ]]; then
    wget https://raw.githubusercontent.com/ribkix/util/master/version.txt -O util_version.txt > /dev/null 2>&1
    printf '%b\n' "$(cat util_version.txt)"
    rm util_version.txt
elif [[ $1 = "plugin-folder" ]]; then
    if [[ ! -d util_plugins ]]; then
      mkdir util_plugins
      echo "Created plugin folder, /util_plugins"
    elif [[ $# = 2 ]]; then
        if [[ $2 = "bypass" ]]; then
            mkdir -p util_plugins
            echo "Created plugin folder, /util_plugins"
        else
            echo "Invalid argument \"$2\""
        fi
    else
        echo "The plugin folder already exists. Run \"util plugin-folder bypass\" to override."
    fi
elif [[ $1 = "plugins" ]]; then
    if [[ "$(ls -A util_plugins)" ]]; then
        ls util_plugins || echo "Plugins folder doesn't exist. Create one using \"util plugin-folder\""
    else
        echo "You have no plugins. Get plugins here: https://github.com/ribkix/util-plugins"
    fi
elif [[ $1 = "library" ]]; then
    xdg-open https://github.com/ribkix/util-plugins
elif [[ $1 = "getviewplugin" ]]; then
    if [[ $# = 2 ]]; then
        wget "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2/description.txt" -O util_viewplugin_description.txt > /dev/null 2>&1
        if [[ -s util_viewplugin_description.txt ]]; then
            echo "URL: https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2"
            echo "Name: $2"
            echo "Description:"
            printf '%b\n' "$(cat util_viewplugin_description.txt)"
            rm util_viewplugin_description.txt
        else
            echo "This plugin doesn't exist."
        fi
    else
        echo "Please specify what plugin you want to view."
    fi
elif [[ $1 = "downloadplugin" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins ]]; then
            mkdir -p util_plugins/$2
            wget "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2/description.txt" -O util_plugins/$2/description.txt > /dev/null 2>&1
            wget "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2/plugin.sh" -O util_plugins/$2/plugin.sh > /dev/null 2>&1
            echo "Done. Run \"util p $2\" to run your new plugin."
        else
            echo "Plugins folder doesn't exist. Create it by running \"util plugin-folder\"."
        fi
    else
        echo "Please specify what plugin you want to view."
    fi
elif [[ $1 = "p" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            chmod +x util_plugins/$2/plugin.sh
            sh util_plugins/$2/plugin.sh
        else
            echo "You don't have this plugin installed. Install it by running \"util downloadplugin $2\""
        fi
    else
        echo "Please specify what plugin you want to run."
    fi
elif [[ $1 = "viewplugin" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            echo "Downloaded from: https://github.com/ribkix/util-plugins/blob/master/plugins/$2"
            echo "Name: $2"
            echo "Description:"
            printf '%b\n' "$(cat util_plugins/$2/description.txt)"
        else
            echo "You don't have this plugin. Try running \"util getviewplugin $2\" to view it from the internet."
        fi
    else
        echo "Please specify what plugin you want to view."
    fi
elif [[ $1 = "deleteplugin" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            rm -rf util_plugins/$2
        else
            echo "You don't have this plugin. Try running \"util plugins\" to view your installed plugins."
        fi
    else
        echo "Please specify what plugin you want to delete."
    fi
elif [[ $1 = "getplugins" ]]; then
    wget https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/all_plugins.txt -O util_getplugins.txt > /dev/null 2>&1
    printf '%b\n' "$(cat util_getplugins.txt)"
    rm util_getplugins.txt
elif [[ $1 = "getchangelog" ]]; then
    wget https://raw.githubusercontent.com/ribkix/util/master/changelog.txt -O util_changelog.txt > /dev/null 2>&1
    printf '%b\n' "$(cat util_changelog.txt)"
    rm util_changelog.txt
elif [[ $1 = "copycmd" ]]; then
    if [[ $# -ge 2 ]]; then
        echo ${*:2} > util_copycmd.txt
    else
        echo "Please specify what command you want to copy."
    fi
elif [[ $1 = "pastecmd" ]]; then
    eval "$(cat util_copycmd.txt)"
elif [[ $1 = "geturl" ]]; then
    if [[ $# -ge 2 ]]; then
        wget ${*:2}
    else
        echo "Please specify what URL you want to download."
    fi
elif [[ $1 = "website" ]]; then
    xdg-open http://utilsh.tk/
elif [[ $1 = "help" ]]; then
    echo "[] - optional argument"
    echo "<> - required argument"
    # echo "<thing1 | thing2> - select one of these options"
    echo "[S] - possible to add \"s-\" before the command to run without root, for example: util s-install"
    echo "(DO NOT INCLUDE THESE WHEN TYPING THE COMMAND)"
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
    echo "MANAGE UTIL"
    echo ""
    echo "util refresh - updates util with new code in the .sh file"
    echo "util getupdate - updates util from the internet (root required)"
    echo "util changelog - shows the changelog"
    echo "util version - shows current version you're running"
    echo "util getversion - gets and shows currently available version"
    echo "util getchangelog - gets and shows current changelog"
    echo ""
    echo "PLUGINS"
    echo ""
    echo "util plugin-folder - creates plugin folder"
    echo "util plugins - view your installed plugins"
    echo "util library - sends you to the plugin library"
    echo "util getviewplugin <plugin> - views the plugin you specified on the internet"
    echo "util downloadplugin <plugin> - download the plugin you specified from the internet"
    echo "util p <plugin> - run plugin"
    echo "util viewplugin <plugin> - view installed plugin you specified."
    echo "util deleteplugin <plugin> - deletes installed plugin you specified."
    echo "util getplugins - view all available plugins."
    echo ""
    echo "MISCELLANEOUS"
    echo ""
    echo "util executable <file> - makes the specified file an executable (root required)"
    echo "util root - login to root"
    echo "util create-root - create root"
    echo "[S] util deb <.deb file> - install deb file (root required)"
    echo "util copycmd <command> - copies the command specified."
    echo "util pastecmd - pastes the command copied."
    echo "util geturl <url> - download file from URL"
    echo "util website - goes to the official Util.sh website"
 else
    echo "Invalid command \"$1\""
    echo "Try running \"util help\""
fi
