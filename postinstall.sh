# add a start menu shortcut
/usr/bin/mkdir -p "$(/usr/bin/cygpath $CYGWINFORALL -P)/Cygwin-X"
/usr/bin/mkshortcut $CYGWINFORALL -P -i /usr/bin/xlaunch.exe -n "Cygwin-X/XLaunch" -a "/usr/bin/bash.exe -l -c /usr/bin/xlaunch.exe" /usr/bin/run.exe

# add file association for opening and editing .xlaunch files
/usr/share/xlaunch/setupreg.sh add
