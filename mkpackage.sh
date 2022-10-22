#!/bin/sh
PACKAGE_PATH=${1:-'files'}

make_package()
{
    tar -zcvf qinsiyuan.tar.gz $PACKAGE_PATH
}

make_shell()
{
echo '#!/bin/sh

sed -n -e "1,/^exit 0$/!p" "$0" > qinsiyuan.tar.gz 2>/dev/null

tar -xzf qinsiyuan.tar.gz

rm -rf qinsiyuan.tar.gz

exit 0' >> qinsiyuan.sh
}

make_bin()
{
    cat qinsiyuan.sh qinsiyuan.tar.gz > install.bin
    chmod a+x install.bin
}

resume()
{
    rm qinsiyuan.sh qinsiyuan.tar.gz
}

make_package
make_shell
make_bin
resume
