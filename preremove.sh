# remove start menu shortcut
rm -f "$(cygpath $CYGWINFORALL -P)/Cygwin-X/XLaunch.lnk"
rmdir --ignore-fail-on-non-empty "$(cygpath $CYGWINFORALL -P)/Cygwin-X"

# remove file association for opening and editing .xlaunch files
/usr/share/xlaunch/setupreg.sh remove

