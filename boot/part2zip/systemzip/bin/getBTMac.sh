#!/system/bin/sh
# LH_SWRD_HenryLi@20110628 get wifi Mac+1

BTMacPath="/data/tmp/BTMac.txt"
#echo "BT MAC address" > "/data/tmp/BTMaclog1.txt"
ls $BTMacPath
IsExist=`echo $?`
case "$IsExist" in
   "1")
	#echo "BT MAC file isn't exist,build it..." > "/data/tmp/BTMaclog2.txt"
	CURstate=`cat /sys/class/rfkill/rfkill0/state`
	case "$CURstate" in
	   "0")
	echo "1" > /sys/class/rfkill/rfkill0/state
	insmod /system/proprietary/wifi/dhd.ko firmware_path=/system/proprietary/wifi/rtecdc.bin nvram_path=/system/proprietary/wifi/nvram.txt
	sleep 5
	wl up
	   ;;
	esac   
	export BT4329Macaddr=`/system/bin/iwgetmac eth0 Macaddr`
	echo $BT4329Macaddr > "/data/tmp/BTMac.txt"
	case "$CURstate" in
	   "0")
	rmmod dhd
	echo "0" > /sys/class/rfkill/rfkill0/state
	   ;;
	esac   
	#/system/bin/brcm_patchram_plus -d --enable_hci  --patchram /system/proprietary/bt/bcm4329.hcd --baudrate 3000000 -bd_addr $BT4329Macaddr /dev/ttyO1
   ;;
esac
