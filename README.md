# SF1500 OSAutoInstaller
SF1500 is a box based on OCTEON TX 64-bit ARM-based CPU and with 2 10Gbps SFP
ports and 8 1Gbps copper ports.


## Description
SF1500 OSAutoInstaller is an integrated tool collection which is used to install
OS (ubuntu16.04.2) on eMMC of SF1500 Network BOX automatically.

## Usage

### Prepare
Before installing OS on SF1500, you may have to connect SF1500 throu
Serial Port or MGMT.

Download components from https://pan.baidu.com/s/1mCLzS_yMgAO8Ex-AbbqOug
   - rootfs.tgz
   - drivers-4.14.11-svn258.tar
Copy these them to "./DS"

Switch to SF1500-OSAutoInstaller and run following commands:
   ./eMMCAutoInstaller.sh

   **NOTE** It will take almost 15 minutes.

   **NOTE**: Please make sure that SF1500 can be accessed through network and
             all above commands are executed on SF1500

### Reboot for a test
<TODO> 
