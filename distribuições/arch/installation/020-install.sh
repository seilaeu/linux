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

sleep 3

reflector --verbose --country Portugal --sort rate --save /etc/pacman.d/mirrorlist 

echo
echo
echo

sleep 3

echo
echo
echo

echo "Instalar o sistema base"

pacstrap -K /mnt/ base linux linux-firmware intel-ucode sudo nano

echo
echo
echo

echo "Verificar o ficheiro /etc/fstab"

genfstab -U /mnt >> /mnt/etc/fstab 

sleep 3

nano /mnt/etc/fstab 

echo
echo
echo

echo "Mudar a raiz para a directoria mnt"

sleep 3

arch-chroot /mnt /bin/bash
