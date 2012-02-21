#!/bin/sh
# Add/Remove Windows registry entries to invoke XLaunch from Explorer context menu

# program to invoke
prog=$(cygpath -w $(which xlaunch))

# HKEY_CURRENT_USER\Software\Classes non-existent on W7

# XXX: either notice if association already exists, and stop
# XXX: or restore the registry to the previous state
# (e.g. if there was already an association) by keeping a backup copy

case "$1" in
remove)
	regtool -v remove "/HKEY_CLASSES_ROOT/.xlaunch"

	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch/Shell/Open/command"
	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch/Shell/Open"

	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch/Shell/Edit/command"
	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch/Shell/Edit"

	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch/Shell"

	regtool -v remove "/HKEY_CLASSES_ROOT/XLaunch"
	;;

add)
	regtool -s -v add "/HKEY_CLASSES_ROOT/.xlaunch"
	regtool -s -v set "/HKEY_CLASSES_ROOT/.xlaunch/" "XLaunch"

	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch"
	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch/Shell"

	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch/Shell/Open"
	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch/Shell/Open/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/XLaunch/Shell/Open/command/" "\"$prog\" -run \"%1\""

	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch/Shell/Edit"
	regtool -s -v add "/HKEY_CLASSES_ROOT/XLaunch/Shell/Edit/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/XLaunch/Shell/Edit/command/" "\"$prog\" -load \"%1\""

	;;
esac

# never report errors
true

# End
