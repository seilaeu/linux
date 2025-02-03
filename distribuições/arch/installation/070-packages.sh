#! /bin/bash

echo
echo
echo

echo "Instalar o Libreoffice"

sudo pacman -S libreoffice-fresh libreoffice-fresh-pt --needed

echo
echo
echo

echo "Instalar o pipewire, o vlc e codecs de media"

echo
echo
echo

sudo pacman -S pipewire wireplumber pipewire-pulse plasma-pa pulsemixer vlc \
gst-plugins-good gst-plugins-bad gst-plugins-ugly --needed

systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo
echo
echo

echo "Instalar compressore e descompressores"

sudo pacman -S unzip unrar --needed

echo
echo
echo

echo "Instalar tipos de letra"

sudo pacman -S ttf-bitstream-vera ttf-dejavu --needed

echo
echo
echo

yay -S ttf-ms-fonts --needed

echo
echo
echo

echo " Instalar o firefox, o protonvpn e o youtube-dl"

echo
echo
echo

sudo pacman -S firefox firefox-i18n-pt-pt wget --needed

echo
echo
echo

yay -S protonvpn youtube-dl --needed

echo
echo
echo

echo "Instalar alguns utilitários"

sudo pacman -S bash-completion ncdu usbutils tree man-db reflector rsync --needed

echo
echo
echo

yay -S preload --needed

echo
echo
echo

sudo systemctl enable --now preload

echo
echo
echo

echo "Instalar o SpiderOak ONE"

echo
echo
echo

yay -S spideroak-one --needed

echo
echo
echo

echo "Instalar a firewall"

echo
echo
echo

sudo pacman -S ufw --needed

echo
echo
echo

sudo ufw enable

echo
echo
echo

sudo ufw status verbose

echo
echo
echo

sudo systemctl enable --now ufw.service

echo
echo
echo

echo "Instalar pacotes de sistema"

sudo pacman -S bind pacman-contrib pkgfile pkgstats whois fwupd --needed
yay -S gdisk --needed
echo
echo
echo

sudo pkgfile -u

echo
echo
echo

echo "Instalar dicionários"

echo
echo
echo

sudo pacman -S aspell-pt --needed

echo
echo
echo

yay -S hunspell-pt_pt mythes-pt_pt --needed

echo
echo
echo
