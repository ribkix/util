About Util.sh
=

Util.sh is a linux script full of commands to make it easier for you to remember very complicated commands or turn multiple commands into one.

Util.sh gets daily updates, and you can leave suggestions under [Issues](https://github.com/ribkix/util/issues).

How to install Util.sh
=

This will guide you through installing util.sh on your linux computer.

Download util.sh
-

Download [the util.sh file](https://raw.githubusercontent.com/ribkix/util/master/util.sh) and put it on your home folder.

Convert to executable
-

To convert the file to executable, run the following commands:
```sh
cp util.sh util
ls -l util
chmod u+x util
ls -l util
chmod a+x util
ls -l util
```
Now, run the following commands, if you don't have a root user, run `sudo passwd root`.
```sh
su
mv util /usr/local/games/util
```

Run util
-

To now run util type `util` and then the command you want to run.
For a list of commands run `util help`.

Commands
=

`[]` - optional argument

`<>` - required argument

`[S]` - possible to add `s-` before the command to run without root, for example: `util s-install`

\(DO NOT INCLUDE THESE WHEN TYPING THE COMMAND)

Files
-

util copy `<file to copy>` `<destination to paste>` - copies and pastes a file
  
util move `<file to move>` `<destination to move it to>` - moves a file
  
util new `<file name>` `[editor]` - makes a new file
  
util del `<file name>` - deletes a file

util geturl `<url>` - download file from URL

util newfolder `<folder name>` - makes new folder

util delfolder `<folder name>` - deletes folder

util disk - shows information on your disk space

Packages
-

`[S]` util install `<package>` - installs what package you specified (root required)
  
util list - shows lists of packages you can install

`[S]` util remove `<package>` - removes what you specified (root required)
  
`[S]` util update - updates list of available packages (root required)

util search `<package>` - searches the package you specified
  
util show `<package>` - shows the package you specified
  
`[S]` util reinstall `<package>` - reinstalls what package you specified (root required)
  
`[S]` util autoremove - automatically removes all unused packages (root required)

`[S]` util upgrade - upgrades the system by installing/upgrading packages (root required)

Manage Util
-

util refresh - updates util with new code in the .sh file

util getupdate - updates util from the internet (root required)

util changelog - shows the changelog

util version - shows current version you're running

util getversion - gets and shows currently available version

util getchangelog - gets and shows current changelog

Plugins
-

util plugin-folder - creates plugin folder

util plugins - view your installed plugins

util library - sends you to the plugin library

util getviewplugin `<plugin>` - views the plugin you specified on the internet

util downloadplugin `<plugin>` - download the plugin you specified from the internet

util p `<plugin>` - run plugin

util viewplugin `<plugin>` - view installed plugin you specified

util deleteplugin `<plugin>` - deletes installed plugin youspecified

util getplugins - view all available plugins

Miscellaneous
-

util executable `<file>` - makes the specified file an executable (root required)
  
util root - login to root

util create-root - create root

`[S]` util deb `.deb file` - install deb file (root required)

util copycmd `<command>` - copies the command specified

util pastecmd `<command>` - pastes the command copied

util website - goes to the official Util.sh website

util listblock - lists the available block devices of your Linux system

Plugins
=

Get plugins here: https://github.com/ribkix/util-plugins

Tutorials
=

See tutorials here: http://utilsh.tk/tutorials
