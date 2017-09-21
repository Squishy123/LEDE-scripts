
echo "Cloning LEDE-SOURCE..."
git clone https://git.lede-project.org/source.git lede

cd lede

echo "Updating feeds..."
./scripts/feeds update -a

echo "Installing feeds..."
./scripts/feeds install -a

echo "Add node to feeds.conf"
echo "src-git node https://github.com/nxhack/openwrt-node-packages.git" >> feeds.default.conf

./scripts/feeds update node
rm ./package/feeds/packages/node
rm ./package/feeds/packages/node-arduino-firmata
rm ./package/feeds/packages/node-cylon
rm ./package/feeds/packages/node-hid
rm ./package/feeds/packages/node-serialport
./scripts/feeds install -a -p node

echo "Making NODEJS Package"
make feeds/node/compile V=s -j5
