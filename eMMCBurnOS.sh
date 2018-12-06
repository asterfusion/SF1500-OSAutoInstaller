
disk=$1

partition1=$disk"p1"
partition2=$disk"p2"

echo "$disk, $partition1 $partition2"

echo "(0) Prepare burn-in environment ..."
BURN_HOME="/mnt/BURN-IN"
mkdir -p $BURN_HOME
dst1=$BURN_HOME/p1
dst2=$BURN_HOME/p2

mkdir $dst1 >/dev/null 2>&1
mkdir $dst2 >/dev/null 2>&1

echo "   mkfs.vfat $partition1"
mkfs.vfat $partition1 >/dev/null 2>&1
echo "   mkfs.ext4 $partition2"
mkfs.ext4 $partition2 >/dev/null 2>&1

echo "(1) Mounting ..."
mount $partition1 $dst1 >/dev/null 2>&1
echo "    +  $partition1 -> $dst1"
mount $partition2 $dst2 >/dev/null 2>&1
echo "    +  $partition2 -> $dst2"

echo "(2) Copying image ..."
cp ./DS/Image.p2 $dst1

echo "(3) Decompressing rootfs ..."
tar -xf ./DS/rootfs.tgz -C $dst2 >/dev/null 2>&1
sync

echo "(4) Install tools ..."
source eMMCInstallTools.sh $dst2

echo "(5) Uninstall burn-in environment ..."
umount $dst1
echo "    -  $partition1 -> $dst1"
umount $dst2
echo "    -  $partition2 -> $dst2"
rm -rf $BURN_HOME

echo "(6) Finished"

