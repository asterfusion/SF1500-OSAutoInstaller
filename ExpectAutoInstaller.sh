
HOME=`pwd`

tar xfvz ./Deps/tcl8.4.11-src.tar.gz
cd tcl8.4.11/unix &&./configure
make
make install
cd $HOME


tar xzvf ./Deps/expect5.45.tar.gz
cd expect5.45 && ./configure --prefix=/usr/expect --with-tclinclude=../tcl8.4.11/generic --build=arm-linux
make
make install
ln -s /usr/tcl/bin/expect /usr/expect/bin/expect


rm tcl8.4.11 expect5.45 -rf
