#! /bin/bash


# Escolher os sites mais rápidos

pacman -Syy
pacman -S reflector --needed 

echo
echo
echo

sleep 3

reflector --verbose --country Portugal --sort rate --save /etc/pacman.d/mirrorlist 

echo
echo
echo

sleep 3

# Instalar sistema base

pacstrap -i /mnt/ base linux sudo nano intel-ucode networkmanager

echo
echo
echo

# Fstab

genfstab -U /mnt >> /mnt/etc/fstab 

nano /mnt/etc/fstab 

echo
echo
echo


# Mudar raiz para a directoria mnt

arch-chroot /mnt /bin/bash
