#!/bin/sh

make_package()
{
    mv files qinsiyuan
    tar -zcvf qinsiyuan.tar.gz qinsiyuan
    mv qinsiyuan files
}

make_shell()
{
echo '#!/bin/sh
install()
{
' > qinsiyuan.sh
if [ -e install.sh ]
then
    cat install.sh >> qinsiyuan.sh
fi

echo '
}

sed -n -e "1,/^exit 0$/!p" "$0" > /tmp/qinsiyuan.tar.gz 2>/dev/null

tar -xzf /tmp/qinsiyuan.tar.gz -C /tmp

cd /tmp/qinsiyuan

install

rm -rf /tmp/qinsiyuan.tar.gz qinsiyuan

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
