# Print the currently used keyboard layout
# This depends on a specifically developed program which prints the group id of
# the currently used layout.
# I developed the simple program myself with some guidance as I was unable to
# find anything already developed.
# Some people might suggest:
# $ setxkbmod -query -v | awk -F "+" '{print $2}'
# this will only work if you have set up XKB with a single layout which is true
# for some.

# This script will print the correct layout even if layout is set per window.
# Exit if platform is not linux as this script is dependant on X11

run_segment() {
	if ! shell_is_osx; then
		return 1
	fi

	cur_layout=`defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | egrep -w 'KeyboardLayout\ Name' | sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/'`
	[ "$cur_layout" == "ABC" ] && cur_layout="English"
	[ "$cur_layout" == "U.S." ] && cur_layout="English"
	echo ${cur_layout:0:2} | awk '{print tolower($0)}'
}
