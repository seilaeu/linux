#! /bin/bash

echo
echo
echo

echo "Escolher os sites mais rápidos"

echo
echo
echo

pacman -Syy

echo
echo
echo

pacman -S reflector rsync --needed

echo
echo
echo

sleep 7

reflector --verbose --country Portugal --sort rate --save /etc/pacman.d/mirrorlist 

echo
echo
echo

sleep 7

echo "Instalar o sistema base"

echo
echo
echo

pacstrap -Ki /mnt/ base linux linux-firmware intel-ucode sudo nano

echo
echo
echo

echo "Verificar o ficheiro /etc/fstab"

echo
echo
echo

genfstab -U /mnt >> /mnt/etc/fstab 

sleep 7

nano /mnt/etc/fstab 

echo
echo
echo

echo "Mudar a raiz para a directoria mnt"

echo
echo
echo

sleep 7

arch-chroot /mnt /bin/bash
