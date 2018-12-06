# Released by TSIHANG (qihang@teraspek.com) on 17 September 2018.
IMAGE_NAME  : ubuntu-16.04.2-et1528-mmc-aarch64.img
BURN_METHOD : dd if=ubuntu-16.04.2-et1528-mmc-aarch64.img of=/dev/mmcblk1
UBOOT_ENV   :
              setenv rootdev "/dev/mmcblk1p2"
              setenv bootargs "console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 debug maxcpus=4 rootwait rw root=$rootdev coherent_pool=16M"
Minicom2.7Minicom2.7setenv bootmmc "fatload mmc 1:1 $kernel_addr Image.p2;booti $kernel_addr - $fdtcontroladdr"
              setenv bootcmd "run bootmmc"
              saveenv



