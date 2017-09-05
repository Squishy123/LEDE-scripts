#!/bin/bash
# Script for installing and setting up an LEDE Development Environment
# that is compatible with custom piratebox feeds
# @author: Christian Wang

clear

echo "WELCOME TO LEDE-DEV-ENV SETUP"

while true; do

  read -n1 -r -p "$(echo -e 'Install Package Dependencies? Y/N\n\b')" yn
  case $yn in
    [Yy]* ) echo "Installing Packages...";
    sudo apt-get install subversion g++ zlib1g-dev build-essential git python rsync man-db
    sudo apt-get install libncurses5-dev gawk gettext unzip file libssl-dev wget
    break;;
    [Nn]* ) break;;
    *) echo "Please answer yes or no"
  esac
done

echo "Please enter the path you want to install the directory in"
read FILE_PATH

cd $FILE_PATH

echo "Cloning LEDE-SOURCE..."
git clone https://git.lede-project.org/source.git lede

cd lede

echo "Cloning Piratebox Feeds..."
git clone https://github.com/PirateBox-Dev/openwrt-piratebox-feed.git piratebox-feed

cd piratebox-feeds
git checkout LEDE_adjustments

cd ..
echo "Making changes to feeds.conf..."
cp  feeds.conf.default feeds.conf
echo "src-link piratebox piratebox-feed" >> feeds.conf

echo "Updating feeds..."
./scripts/feeds update -a

echo "Installing feeds..."
./scripts/feeds install -a

make defconfig

echo "All done. Run make menuconfig to start building"
