
disk="/dev/mmcblk1"
partition1=$disk"p1"
partition2=$disk"p2"

DL_LINK="https://pan.baidu.com/s/1mCLzS_yMgAO8Ex-AbbqOug"
SWITCH_DRIVER="drivers-4.14.11-svn258.tar.gz"
ROOTFS="rootfs.tgz"

logfile="./install.log"

expect_bin=expect
command -v $expect_bin >/dev/null 2>&1 || { echo >&2 "$expect_bin is required, while it's not installed.  Aborting."; exit 1; }

if [ ! -f "./DS/$SWITCH_DRIVER" ];then
	echo "Cannot find $SWITCH_DRIVER (Switch Driver), please download from $DL_LINK"
	exit
fi

if [ ! -f "./DS/$ROOTFS" ];then
	echo "Cannot find $ROOTFS, please download from $DL_LINK"
        exit
fi

echo "Starting installer at `date`" >> $logfile

# Umount
p1=`df -h | grep $partition1 | awk '{print$6}'`
p2=`df -h | grep $partition2 | awk '{print$6}'`

if [ "$p1"X != ""X ]; then
	umount $p1
fi

if [ "$p2"X != ""X ]; then
	umount $p2
fi



# Format /dev/mmcblk1
mkfs.ext4 $disk

# Partition
expect ./eMMCPartition.exp $disk

# Burning
source ./eMMCBurnOS.sh $disk

echo "Finish   installer at `date`" >> $logfile
