#!/bin/sh
# Add/Remove Windows registry entries to invoke XLaunch from Explorer context menu

# program to invoke
prog="\"$(cygpath -w $(which run))\""
opencmd="\"$(cygpath -w $(which bash))\" -l -c \"xlaunch -run  \\\"%1\\\"\""
editcmd="\"$(cygpath -w $(which bash))\" -l -c \"xlaunch -load \\\"%1\\\"\""

# ProgID that extension will point to
ProgID=XLaunch.cygwin

case "$1" in
    remove)
        # MSFT guidelines say only remove the ProgID, not the extension
	# when uninstalled, in case it points to another application now

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open/command"
	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open"

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit/command"
	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit"

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/Shell"

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID"
	;;

    add)
	regtool -s -v add "/HKEY_CLASSES_ROOT/.xlaunch"
	regtool -s -v set "/HKEY_CLASSES_ROOT/.xlaunch/" "$ProgID"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open/command/" "$prog $opencmd"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit/command/" "$prog $editcmd"
	;;
esac

# never report errors
true
