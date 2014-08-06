#!/system/bin/sh

#/system/bin/log -t wifi "reset wifi state"
echo "0" > /sys/class/rfkill/rfkill0/state
echo "0" > /sys/class/rfkill/rfkill1/state
