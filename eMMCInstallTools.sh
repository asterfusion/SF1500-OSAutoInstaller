
dir=$1/lib/modules/4.14.11-svn258
mkdir -p $dir
tar -xf ./DS/drivers-4.14.11-svn258.tar.gz -C $dir  >/dev/null 2>&1
ln -s $dir $1/lib/modules/4.14.11

tar -xf ./DS/tools-update.tar.gz  >/dev/null 2>&1
cd tools-update && ./tools-update.sh $1
cd - && rm tools-update -rf

