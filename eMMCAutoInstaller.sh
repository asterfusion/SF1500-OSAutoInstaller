
disk="/dev/vsd"
partition1=$disk"p1"
partition2=$disk"p2"

logfile="./install.log"
expect_bin=expect

command -v $expect_bin >/dev/null 2>&1 || { echo >&2 "$expect_bin is required, while it's not installed.\n  Aborting."; exit 1; }

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