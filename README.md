# checkAdamID

This script is adapted from a script I used to ingest the results of a MySQL query. In my use-case,
some app records were marked as "not in App Store" incorrectly - the following MySQL query was written
to find applications which were marked as "not in app store" but not deleted:

'''select itunes_id from mobile_device_apps where available_in_appstore=0 and deleted=0;
'''

checkAdamID has been adapted to accept user input - I also filtered the mysql results through the
following hacky scripting. My motto is "why do it if you're not using 4+ pipes" - there are more
efficient ways to do this, but I was just slapping something together.

'''cat "$adamIDInput" | sed -e '1,/^\+/d' -e 's/\|\ //' | sed -e '1,/^\+/d' -e 's/\ \|//' -e '/^\+/,$ d' > $newFileName
'''

These lines only apply if you're working with Jamf Pro - if you're working from a different platform, this
script could still be useful, and as a result I haven't combined all of them for you. If you're working
in Jamf Pro and have direct access to your DB, you could just combine all of this into one script and 
skip the user-input portion of things. That's up to you.

et-j
