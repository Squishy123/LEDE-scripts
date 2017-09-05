#!/bin/bash
# Script for setting up extroot with USB in LEDE
# @author: Christian Wang
clear

echo "WELCOME TO EXTROOT CONFIG"

while true; do

  read -n1 -r -p "$(echo -e 'Install Package Dependencies? (IF YOU HAVE MORE THAN 8MB OF FLASH) Y/N\n\b')" yn
  case $yn in
    [Yy]* ) echo "Installing Packages...";
    opkg update && opkg install block-mount  kmod-fs-f2fs kmod-usb-storage mkf2fs f2fsck kmod-usb-ohci kmod-usb-uhci fdisk
    break;;
    [Nn]* ) break;;
    *) echo "Please answer yes or no"
  esac
done


echo "Please select the mounted USB (TODO CUSTOM QUERY -> Currently grabbing usb device at /dev/sda1)"
block info

#Formatting the usb to f2fs
echo "Formatting the USB to f2fs"
mkfs.f2fs /dev/sda1

echo "Transferring the current overlay into the USB"
mount /dev/sda1 /mnt ; tar -C /overlay -cvf - . | tar -C /mnt -xf - ; umount /mnt

echo "Creating fstab uci subsystem and configuring it to use /dev/sda1 as it's overlay"
block detect > /etc/config/fstab; \
   sed -i s/option$'\t'enabled$'\t'\'0\'/option$'\t'enabled$'\t'\'1\'/ /etc/config/fstab; \
   sed -i s#/mnt/sda1#/overlay# /etc/config/fstab; \
   cat /etc/config/fstab;

echo "Mounting /dev/sda1 as /overlay"
mount /dev/sda1 /overlay

echo "Check to make sure /dev/sda1 is mounted as /overlay"
df

echo "EXTROOT INSTALL COMPLETE"
echo "REBOOTING..."
reboot
