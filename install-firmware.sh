#!/bin/bash
# Script for Installing Firmware File On LEDE

clear

echo "Type in the name of the firmware file to flash"
read firmware

echo "Whats the router's ipaddress?"
read IP


while true; do
  clear 
  read -n1 -r -p "$(echo -e 'CONNECT TO THE ROUTER NOW. WHEN READY TYPE "Y" TO START FIRMWARE INSTALL')" y
  case $y in
    [Yy]* )
    echo "CONNECTING TO ROUTER"
    echo "COPYING OVER FIRMWARE FILE"
    scp $firmware root@$IP:/tmp
    ssh root@$IP 'sysupgrade -n -F /tmp/$firmware'
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
