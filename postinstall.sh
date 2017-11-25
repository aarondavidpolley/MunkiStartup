#!/bin/bash

################################################################################
# Author:    Aaron Polley                                                      #
# Date:      25/11/2017                                                        #
# Version:   1.0                                                               #
# Purpose:   Post install script for MunkiStartup                              #
################################################################################

#---Variables and such---#
script_version="1.0"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir=`dscl . read /Users/"$user_name" NFSHomeDirectory | awk '{print $2}'`
log_file="/var/log/MunkiStartup_Install.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
currentUser=`/usr/bin/stat -f%Su /dev/console`
DateTime=`date "+%a %b %d %H:%M:%S"`
OldVersion="/Library/LaunchDaemons/com.max.munkistartup.plist"

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

# Run postinstall actions for root.

echo "$DateTime - Loading scripts into launchd"

#Check if v0.1 LaunchDaemon exists#

if [ -e "$OldVersion" ]; then

#Unload and remove old Daemon#

launchctl unload -w /Library/LaunchDaemons/com.max.munkistartup.plist
rm /Library/LaunchDaemons/com.max.munkistartup.plist

else

#Unload LaunchDaemon#

launchctl unload /Library/LaunchDaemons/com.github.aarondavidpolley.munkistartup.plist

fi

#Load LaunchDaemon#

launchctl load -w /Library/LaunchDaemons/com.github.aarondavidpolley.munkistartup.plist

echo "$DateTime - Complete..."

echo "*************************************************************************"



exit 0
