#!/bin/bash
# Script for Soft-Bricking WR902-AC

clear
echo "DOWNLOADING FIRMWARE IMAGE"
wget 'http://static.tp-link.com/TL-WR902AC(US)_V1_160905.zip'

echo "EXTRACTING IMAGE"
unzip 'TL-WR902AC(US)_V1_160905.zip'

echo "RENAMING"
mv "TL-WR902AC(US)_V1_160905/"*.bin original.bin

while true; do
  clear 
  read -n1 -r -p "$(echo -e 'CONNECT TO THE ROUTER NOW. WHEN READY TYPE "Y" TO START FIRMWARE INSTALL')" y
  case $y in
    [Yy]* )
    echo "CONNECTING TO ROUTER"
    echo "COPYING OVER FIRMWARE FILE"
    scp 'original.bin' root@192.168.1.1:/tmp
    ssh root@192.168.1.1 'sysupgrade -n -F /tmp/original.bin'
    exit
    break;;
    [Nn]* ) break;;
    *) echo "PLEASE ANSWER YES OR NO"
  esac
done

echo "EXITING.."
~
~
~
~
