#!/bin/bash

################################################################################
# Author:    Aaron Polley                                                      #
# Date:      02/09/2017                                                        #
# Version:   0.01                                                              #
# Purpose:   Post install script for MunkiStartup                                  #
################################################################################

#---Variables and such---#
script_version="0.01"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir=`dscl . read /Users/"$user_name" NFSHomeDirectory | awk '{print $2}'`
log_file="/var/log/MunkiStartup_Install.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
currentUser=`/usr/bin/stat -f%Su /dev/console`
DateTime=`date "+%a %b %d %H:%M:%S"`

#---Redirect output to log---#
exec >> $log_file 2>&1


#---Script Start---#
echo "*************************************************************************"
echo "$DateTime - MunkiStartup postinstall v${script_version}"
echo "$DateTime     - User:              $user_name"
echo "$DateTime     - User ID:           $user_id"
echo "$DateTime     - Home Dir:          $home_dir"
echo "$DateTime     - OS Vers:           10.${os_vers}"
echo "$DateTime     - LoadUser:          $currentUser"

# This is useful for loading launch daemons and agents.

    # Run postinstall actions for root.
    echo "$DateTime - Executing postinstall scripts"
    # Add commands to execute in system context here.

	launchctl unload /Library/LaunchDaemons/com.max.munkistartup.plist
	launchctl load -w /Library/LaunchDaemons/com.max.munkistartup.plist

echo "$DateTime - Complete..."

echo "*************************************************************************"

exit 0
