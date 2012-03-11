#!/bin/sh
# Add/Remove Windows registry entries to invoke XLaunch from Explorer context menu

# XXX: /HKCR is a merged view of /HKLM/Software/Classes and /HKCU/Software/Classes
# Does writing work correctly for Admin and non-admin users?

# program to invoke
prog="\"$(cygpath -w $(which run))\""
opencmd="\"$(cygpath -w $(which bash))\" -l -c \"xlaunch -run  \\\"%1\\\"\""
editcmd="\"$(cygpath -w $(which bash))\" -l -c \"xlaunch -load \\\"%1\\\"\""

# document icon to use
# (we must set this or we get the run icon, which isn't what we want)
icon="$(cygpath -w $(which xlaunch)).exe,1"

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

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID/DefaultIcon"

	regtool -v remove "/HKEY_CLASSES_ROOT/$ProgID"
	;;

    add)
	regtool -s -v add "/HKEY_CLASSES_ROOT/.xlaunch"
	regtool -s -v set "/HKEY_CLASSES_ROOT/.xlaunch/" "$ProgID"
	# XXX: should also add to OpenWithProgIds

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/$ProgID/Shell/Open/command/" "$prog $opencmd"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit"
	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit/command"
	regtool -s -v set "/HKEY_CLASSES_ROOT/$ProgID/Shell/Edit/command/" "$prog $editcmd"

	regtool -s -v add "/HKEY_CLASSES_ROOT/$ProgID/DefaultIcon"
	regtool -s -v set "/HKEY_CLASSES_ROOT/$ProgID/DefaultIcon/" "$icon"
	;;
esac

# never report errors
true
