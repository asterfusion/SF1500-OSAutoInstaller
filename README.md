
# Description

SF1500 OSAutoInstaller is an integrated tool collection which is used to help you installing OS (ubuntu16.04.2) on eMMC of SF1500 Network BOX automatically. There are 3 most important parts in it.

   - Partition for eMMC
   - Burn image and root filesystem

**NOTE** SF1500 is a box based on OCTEON TX 64-bit ARM-based CPU and with 2 10Gbps SFP ports and 8 1Gbps copper ports.

## Partition

For eMMC booting, there are two partitions which is listed below:

   - /dev/mmcblk1p1, GPT (0xEF00), 100MB, for linux image.
   - /dev/mmcblk1p2, Linux FileSystem (0x8300), the remaining space, for root filesystem.

The auto installer makes partitions by using gdisk tool. Please read eMMCPartition.exp for more details.

## Burn image and root filesystem

There are some decompressed files in directory $OSAutoInstallerHome/DS

   - Image.p2
   - rootfs.tgz (download from [here](https://pan.baidu.com/s/1mCLzS_yMgAO8Ex-AbbqOug "www.pan.baidu.com"))

**NOTE** You must reconfigure boot method to support eMMC booting at stage of uboot. The way how to reconfigure uboot will be showed at the end of this introduction (chapter Q&A).

# Usage

**NOTE** Please make sure that SF1500 can access network (MGMT port).

  (1) Download components from [here](https://pan.baidu.com/s/1mCLzS_yMgAO8Ex-AbbqOug "www.pan.baidu.com")

   - rootfs.tgz
   - drivers-4.14.11-svn258.tar

  (2) Copy them to "SF1500-OSAutoInstaller/DS"

  (3) Switch to SF1500-OSAutoInstaller and run following commands:

	./eMMCAutoInstaller.sh

**NOTE** It will take almost 15 minutes.

# Example
The following is an example of output on SF1500 while installing OS.

	root@OCTEONTX:/root/SF1500-OSAutoInstaller# ./eMMCAutoInstaller.sh
	mke2fs 1.42.13 (17-May-2015)
	Found a gpt partition table in /dev/mmcblk1
	Proceed anyway? (y,n) y
	Discarding device blocks: done                            
	Creating filesystem with 944128 4k blocks and 236176 inodes
	Filesystem UUID: 86a6fc58-9128-43ec-8a98-12b0ea28c84f
	Superblock backups stored on blocks: 
			32768, 98304, 163840, 229376, 294912, 819200, 884736

	Allocating group tables: done                            
	Writing inode tables: done                            
	Creating journal (16384 blocks): done
	Writing superblocks and filesystem accounting information: done 

	arg0: /dev/mmcblk1
	1. Formatting disk /dev/mmcblk1 ...
	2. Trying to disk partitioning for /dev/mmcblk1
	spawn gdisk /dev/mmcblk1
	GPT fdisk (gdisk) version 1.0.1

	Partition table scan:
	  MBR: not present
	  BSD: not present
	  APM: not present
	  GPT: not present

	Creating new GPT entries.

	Command (? for help): n
	Partition number (1-128, default 1): 
	First sector (34-7552990, default = 2048) or {+-}size{KMGTP}: 
	Last sector (2048-7552990, default = 7552990) or {+-}size{KMGTP}: 100M
	Current type is 'Linux filesystem'
	Hex code or GUID (L to show codes, Enter = 8300): ef00
	Changed type of partition to 'EFI System'

	Command (? for help): n
	Partition number (2-128, default 2): 
	First sector (34-7552990, default = 206848) or {+-}size{KMGTP}: 
	Last sector (206848-7552990, default = 7552990) or {+-}size{KMGTP}: 
	Current type is 'Linux filesystem'
	Hex code or GUID (L to show codes, Enter = 8300): 8300
	Changed type of partition to 'Linux filesystem'

	Command (? for help): w

	Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
	PARTITIONS!!

	Do you want to proceed? (Y/N): Y
	OK; writing new GUID partition table (GPT) to /dev/mmcblk1.

	The operation has completed successfully.
	/dev/mmcblk1, /dev/mmcblk1p1 /dev/mmcblk1p2
	(0) Prepare burn-in environment ...
		mkfs.vfat /dev/mmcblk1p1
		mkfs.ext4 /dev/mmcblk1p2
	(1) Mounting ...
		+  /dev/mmcblk1p1 -> /mnt/BURN-IN/p1
		+  /dev/mmcblk1p2 -> /mnt/BURN-IN/p2
	(2) Copying image ...
	(3) Decompressing rootfs ...
	(4) Install tools ...
	tools install success
	/mnt/sdx/SF1500-OSAutoInstaller
	(5) Uninstall burn-in environment ...
		-  /dev/mmcblk1p1 -> /mnt/BURN-IN/p1
		-  /dev/mmcblk1p2 -> /mnt/BURN-IN/p2
	(6) Finished

# Q&A

## How to make a USB startup disk ?
<TODO>

## How to boot from eMMC ?
You can change the booting method on u-boot to boot from eMMC with the following commands:

	SFF8104> setenv bootcmd "run bootmmc"
	SFF8104> setenv bootargs "bootargs=console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 debug maxcpus=4 rootwait rw root=/dev/mmcblk1p2 coherent_pool=16M"
	SFF8104> saveenv
	SFF8104> reset

## How to boot from USB ?
You can change the booting method on u-boot to boot from USB with the following commands:

	SFF8104> setenv bootcmd "run bootusb"
	SFF8104> setenv bootargs "console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 debug maxcpus=4 rootwait rw root=/dev/sda2 coherent_pool=16M"
	SFF8104> saveenv
	SFF8104> reset

