#! /bin/bash

echo
echo
echo

echo "Definir o fuso horário para Lisboa"

ln -sfv /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

hwclock --systohc

echo
echo
echo

sleep 3

echo "Localização"

echo
echo
echo

echo "pt_PT.UTF-8 UTF-8" | tee /etc/locale.gen

locale-gen 

echo
echo
echo

sleep 3

echo "Definir idioma"

echo
echo
echo

echo "LANG=pt_PT.UTF-8" | tee /etc/locale.conf

echo
echo
echo

sleep 3

echo "Definir o tipo de letra e teclado no terminal"

echo
echo
echo

echo "KEYMAP=pt-latin9" | tee  /etc/vconsole.conf
echo "FONT=lat1-16" | tee -a /etc/vconsole.conf
echo "FONT_MAP=8859-1" | tee -a /etc/vconsole.conf

echo
echo
echo

sleep 3

echo "Configuração da rede"

echo
echo
echo

echo arch | tee /etc/hostname

echo
echo
echo

echo "127.0.0.1	localhost" | tee /etc/hosts

echo "::1		localhost" | tee -a /etc/hosts

echo "127.0.1.1      arch" | tee -a /etc/hosts

echo
echo
echo

sleep 3

echo "Instalar o gestor de rede"

echo
echo
echo

pacman -S networkmanager --needed

echo
echo
echo

systemctl enable NetworkManager

echo
echo
echo

sleep 3

echo 'Descomentar a linha wheel no ficheiro /etc/sudoers'

echo
echo
echo

sleep 3

EDITOR=nano visudo

echo "Definir a palavra passe do root"

echo
echo
echo

sleep 3

passwd 

echo
echo
echo

echo "Adicionar utilizador seilaeu"

useradd -m -g users -G wheel -s /bin/bash seilaeu

echo
echo
echo

grep seilaeu /etc/passwd

echo
echo
echo

groups seilaeu

echo
echo
echo

echo "Definir a palavra passe de seilaeu"

echo
echo
echo

sleep 3

passwd seilaeu 

echo
echo
echo

echo "Instalar e configurar o carregador de arranque"

echo
echo
echo

pacman -S grub efibootmgr --needed

echo
echo
echo 

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch

grub-mkconfig -o /boot/grub/grub.cfg

echo
echo
echo
