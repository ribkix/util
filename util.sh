#!/bin/bash

version="2020.8.10"

if [[ $1 = "changelog" ]]; then
    echo "=+= What's new in Version $version =+="
    echo ""
    echo "- Added path command"
    echo "- Added up to date and need to update text to the getchangelog command"
    echo "- Added blog command"
    echo "- Added blogpost command"
    echo "- Bug fixes"
    echo ""
    echo "Run \"util blogpost\" to see the blog post of this changelog."
elif [[ $1 =  "executable" ]]; then
    if [[ $# = 2 ]]; then
        if [[ $EUID = 0 ]]; then
            cp $2 ${2%%.*}
            ls -l ${2%%.*} > /dev/null 2>&1
            chmod u+x ${2%%.*}
            ls -l ${2%%.*} > /dev/null 2>&1
            chmod a+x ${2%%.*}
            ls -l ${2%%.*} > /dev/null 2>&1
            mv ${2%%.*} /usr/local/games/${2%%.*}
            echo "Done, run \"${2%%.*}\""
        else
            echo "This command must be run under root."
        fi
    else
        echo "Please specify the file you want to make executable."
    fi
elif [[ $1 =  "s-executable" ]]; then
    if [[ $# = 2 ]]; then
        cp $2 ${2%%.*}
        ls -l ${2%%.*} > /dev/null 2>&1
        chmod u+x ${2%%.*}
        ls -l ${2%%.*} > /dev/null 2>&1
        chmod a+x ${2%%.*}
        ls -l ${2%%.*} > /dev/null 2>&1
        sudo mv ${2%%.*} /usr/local/games/${2%%.*}
        echo "Done, run \"${2%%.*}\""
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
        ls -l util > /dev/null 2>&1
        chmod u+x util
        ls -l util > /dev/null 2>&1
        chmod a+x util
        ls -l util > /dev/null 2>&1
        mv util /usr/local/games/util
        echo "Done"
    else
        echo "This command must be run under root."
    fi
elif [[ $1 =  "s-refresh" ]]; then
    cp util.sh util
    ls -l util > /dev/null 2>&1
    chmod u+x util
    ls -l util > /dev/null 2>&1
    chmod a+x util
    ls -l util > /dev/null 2>&1
    sudo mv util /usr/local/games/util
    echo "Done"
elif [[ $1 = "getupdate" ]]; then
    if [[ $EUID = 0 ]]; then
        wget https://raw.githubusercontent.com/ribkix/util/master/util.sh -O util.sh > /dev/null 2>&1
        cp util.sh util
        ls -l util > /dev/null 2>&1
        chmod u+x util
        ls -l util > /dev/null 2>&1
        chmod a+x util
        ls -l util > /dev/null 2>&1
        mv util /usr/local/games/util
        echo "Done"
        wget https://raw.githubusercontent.com/ribkix/util/master/changelog.txt -O util_changelog.txt > /dev/null 2>&1
        printf '%b\n' "$(cat util_changelog.txt)"
        rm util_changelog.txt
    else
        echo "This command must be run under root."
    fi
elif [[ $1 = "s-getupdate" ]]; then
    wget https://raw.githubusercontent.com/ribkix/util/master/util.sh -O util.sh > /dev/null 2>&1
    cp util.sh util
    ls -l util > /dev/null 2>&1
    chmod u+x util
    ls -l util > /dev/null 2>&1
    chmod a+x util
    ls -l util > /dev/null 2>&1
    sudo mv util /usr/local/games/util
    echo "Done"
    wget https://raw.githubusercontent.com/ribkix/util/master/changelog.txt -O util_changelog.txt > /dev/null 2>&1
    printf '%b\n' "$(cat util_changelog.txt)"
    rm util_changelog.txt
elif [[ $1 = "version" ]]; then
    echo "$version"
elif [[ $1 = "getversion" ]]; then
    wget https://raw.githubusercontent.com/ribkix/util/master/version.txt -O util_version.txt > /dev/null 2>&1
    printf '%b\n' "$(cat util_version.txt)"
    if [[ $(< util_version.txt) != "$version" ]]; then 
        echo "You should update, run \"util getupdate\"."
    else
        echo "Version up to date."
    fi
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
        else
            echo "This plugin doesn't exist."
        fi
        rm util_viewplugin_description.txt
    else
        echo "Please specify what plugin you want to view."
    fi
elif [[ $1 = "downloadplugin" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins ]]; then
            if curl --output /dev/null --silent --head --fail "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2"; then
                mkdir -p util_plugins/$2
                wget "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2/description.txt" -O util_plugins/$2/description.txt > /dev/null 2>&1
                wget "https://raw.githubusercontent.com/ribkix/util-plugins/master/plugins/$2/plugin.sh" -O util_plugins/$2/plugin.sh > /dev/null 2>&1
                echo "Done. Run \"util p $2\" to run your new plugin."
            else
                echo "This plugin doesn't exist. "
            fi
        else
            echo "Plugins folder doesn't exist. Create it by running \"util plugin-folder\"."
        fi
    else
        echo "Please specify what plugin you want to view."
    fi
elif [[ $1 = "p" ]]; then
    if [[ $# -ge 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            if [[ $# = 2 ]]; then
                bash util_plugins/$2/plugin.sh
            elif [[ $# -ge 3 ]]; then
                bash util_plugins/$2/plugin.sh "${*:3}"
            fi
        else
            echo "You don't have this plugin installed. Install it by running \"util downloadplugin $2\"."
        fi
    else
        echo "Please specify what plugin you want to run."
    fi
elif [[ $1 = "sp" ]]; then
    if [[ $# -ge 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            if [[ $# = 2 ]]; then
                sudo bash util_plugins/$2/plugin.sh
            elif [[ $# -ge 3 ]]; then
                sudo bash util_plugins/$2/plugin.sh "${*:3}"
            fi
        else
            echo "You don't have this plugin installed. Install it by running \"util downloadplugin $2\"."
        fi
    else
        echo "Please specify what plugin you want to run."
    fi
elif [[ $1 = "viewplugin" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
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
    wget https://raw.githubusercontent.com/ribkix/util/master/version.txt -O util_version.txt > /dev/null 2>&1
    echo ""
    if [[ $(< util_version.txt) != "$version" ]]; then 
        echo "You should update, run \"util getupdate\"."
    else
        echo "Version up to date."
    fi
    rm util_version.txt
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
elif [[ $1 = "createplugin" ]]; then
    read -p "Plugin name: " createplugin_name
    read -p "Plugin description: " createplugin_description
    echo ""
    mkdir -p util_plugins/$createplugin_name
    echo $createplugin_description > util_plugins/$createplugin_name/description.txt
    > util_plugins/$createplugin_name/plugin.sh
    echo "Created util_plugins/$createplugin_name, edit it using util editplugin $createplugin_name <description | plugin> [editor]"
elif [[ $1 = "newfolder" ]]; then
    if [[ $# -ge 2 ]]; then
        mkdir ${*:2}
    else
        echo "Please specify the folder name you want to create."
    fi
elif [[ $1 = "delfolder" ]]; then
    if [[ $# -ge 2 ]]; then
        rmdir ${*:2}
    else
        echo "Please specify the folder you want to delete."
    fi
elif [[ $1 = "listblock" ]]; then
    lsblk
elif [[ $1 = "disk" ]]; then
    df
elif [[ $1 = "tutorials" ]]; then
    xdg-open http://utilsh.tk/tutorials
elif [[ $1 = "delexe" ]]; then
    if [[ $# = 2 ]]; then
        rm /usr/local/games/$2
    else
        echo "Please specify the executable you want to delete."
    fi
elif [[ $1 = "s-delexe" ]]; then
    if [[ $# = 2 ]]; then
        sudo rm /usr/local/games/$2
    else
        echo "Please specify the executable you want to delete."
    fi
elif [[ $1 = "viewexes" ]]; then
    ls --color /usr/local/games
elif [[ $1 = "find" ]]; then
    if [[ $# -ge 2 ]]; then
        grep ${*:2}
    else
        echo "Please specify the text and the file."
    fi
elif [[ $1 = "open" ]]; then
    if [[ $# = 2 ]]; then
        xdg-open $2
    else
        echo "Please specify the file you want to open."
    fi
elif [[ $1 = "editexe" ]]; then
    if [[ $# = 2 ]]; then
        xdg-open /usr/local/games/$2
    elif [[ $# = 3 ]]; then
        $3 /usr/local/games/$2
    else
        echo "Please specify the executable and optionally the editor."
    fi
elif [[ $1 = "editplugin" ]]; then
    if [[ $# = 3 ]]; then
        if [[ $3 = description ]]; then 
            xdg-open util_plugins/$2/description.txt
        elif [[ $3 = plugin ]]; then 
            xdg-open util_plugins/$2/plugin.sh
        else
            echo "Invalid argument \"$2\", it can be \"description\" or \"plugin\"."
        fi
    elif [[ $# = 4 ]]; then
        if [[ $3 = description ]]; then 
            $4 util_plugins/$2/description.txt
        elif [[ $3 = plugin ]]; then 
            $4 util_plugins/$2/plugin.sh
        else
            echo "Invalid argument \"$2\", it can be \"description\" or \"plugin\"."
        fi
    else
        echo "Please specify what plugin you want to edit, what part you want to edit and optionally the editor."
    fi
elif [[ $1 = "size" ]]; then
    if [[ $# -ge 2 ]]; then
        du -sh ${*:2}
    else
        echo "Please specify the file you want to view the size of."
    fi
elif [[ $1 = "view" ]]; then
    if [[ $# = 2 ]]; then 
        ls --color $2
    elif [[ $# -ge 2 ]]; then
        ls --color $2 ${*:3}
    else
        ls --color
    fi
elif [[ $1 = "generateupload" ]]; then
    if [[ $# = 2 ]]; then
        if [[ -d util_plugins/$2 ]]; then
            read -p "Screenshots (Image URL) (seperate with spaces) (leave blank to not do): " generateupload_screenshots
            read -p "Usage (leave blank to not do): " generateupload_usage
            read -p "Website (leave blank to not do): " generateupload_website
            echo ""
            echo "---------------------------- COPY BELOW"
            echo ""
            echo "$2"
            echo "-"
            echo ""
            printf '%b\n' "$(cat util_plugins/$2/description.txt)"
            echo ""
            if [[ "${generateupload_screenshots}" != "" ]]; then 
                read -r -a generateupload_screenshots_array <<< echo "$generateupload_screenshots"
                echo "Screenshots:"
                for screenshot in "${generateupload_screenshots_array[@]}"
                do
                    echo "![Image](${screenshot},\"icon\")"
                done
                echo ""
            fi
            if [[ "${generateupload_usage}" != "" ]]; then 
                echo "Usage:"
                echo $generateupload_usage
                echo ""
            fi
            if [[ "${generateupload_website}" != "" ]]; then
                echo "[Website]($generateupload_website)"
                echo ""
            fi
            printf '%b\n' "$(cat util_plugins/$2/plugin.sh)"
            echo ""
            echo "---------------------------- COPY ABOVE"
            echo ""
            echo "We will automatically make a download link for the plugin code. Don't worry."
        else
            echo "This plugin doesn't exist, view your plugins using \"util plugins\"."
        fi
    else
        echo "Please specify the plugin."
    fi
elif [[ $1 = "path" ]]; then
    pwd
elif [[ $1 = "blog" ]]; then
    xdg-open https://utilsh.tk/blog
elif [[ $1 = "blogpost" ]]; then
    xdg-open https://utilsh.tk/blog#2020-8-10
elif [[ $1 = "help" ]]; then
    echo "[argument] - optional argument"
    echo "<argument> - required argument"
    echo "<argument: thing1 | thing2> - select one of these options"
    echo "[S] - possible to add \"s-\" before the command to run without root, for example: util s-install"
    echo "(DO NOT INCLUDE THESE WHEN TYPING THE COMMAND)"
    echo ""
    echo "FILES"
    echo ""
    echo "util copy <file to copy> <destination to paste> - copies and pastes a file"
    echo "util move <file to move> <destination to move it to> - moves a file"
    echo "util new <file name> [editor] - makes a new file"
    echo "util del <file name> - deletes a file"
    echo "util geturl <url> - download file from URL"
    echo "util newfolder <folder name> - makes new folder"
    echo "util delfolder <folder name> - deletes folder"
    echo "util disk - shows information on your disk space"
    echo "util find <text> <file name> - finds text you specified in the file you specified"
    echo "util open <file name> - opens file with the default program for the file extension"
    echo "util size <file name> - shows the size of the file you specified"
    echo "util view [path] [options] - views the files of the current path or if specified the specified path with optional options"
    echo "util path - shows current path"
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
    echo "[S] util refresh - updates util with new code in the .sh file"
    echo "[S] util getupdate - updates util from the internet (root required)"
    echo "util changelog - shows the changelog"
    echo "util version - shows current version you're running"
    echo "util getversion - gets and shows currently available version"
    echo "util getchangelog - gets and shows current changelog"
    echo "util blogpost - goes to the official Util.sh blog post of your current version"
    echo ""
    echo "PLUGINS"
    echo ""
    echo "util plugin-folder - creates plugin folder"
    echo "util plugins - view your installed plugins"
    echo "util library - sends you to the plugin library"
    echo "util getviewplugin <plugin> - views the plugin you specified on the internet"
    echo "util downloadplugin <plugin> - download the plugin you specified from the internet"
    echo "util p <plugin> - run plugin"
    echo "util sp <plugin> - run plugin under sudo"
    echo "util viewplugin <plugin> - view installed plugin you specified"
    echo "util deleteplugin <plugin> - deletes installed plugin you specified"
    echo "util getplugins - view all available plugins"
    echo "util createplugin - creates plugin"
    echo "util editplugin <plugin> <part: description | plugin> [editor] - edits plugin you specified with the editor you specified, if there is no editor specified it will use your default editor"
    echo "util generateupload <plugin> - generates upload code for plugin"
    echo ""
    echo "MISCELLANEOUS"
    echo ""
    echo "[S] util executable <file> - makes the specified file an executable (root required)"
    echo "util root - login to root"
    echo "util create-root - create root"
    echo "[S] util deb <.deb file> - install deb file (root required)"
    echo "util copycmd <command> - copies the command specified"
    echo "util pastecmd - pastes the command copied"
    echo "util website - goes to the official Util.sh website"
    echo "util listblock - lists the available block devices of your Linux system"
    echo "util tutorials - goes to the official Util.sh tutorials"
    echo "[S] util delexe <executable> - deletes executable (root required)"
    echo "util viewexes - views executables"
    echo "util editexe <executable> [editor] - edits executable with the editor you specified, if you specified no editor it opens it in your default editor"
    echo "util blog - goes to the official Util.sh blog"
 else
    echo "Invalid command \"$1\""
    echo "Try running \"util help\""
fi
