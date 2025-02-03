#! /bin/bash

echo
echo
echo

echo "Instalar o Plasma 5"

echo
echo
echo

sudo pacman -S plasma-desktop konsole kate dolphin ark kcalc okular gwenview plasma-pa kwalletmanager \
ktorrent elisa breeze-gtk kde-gtk-config kmymoney plasma-systemmonitor kdeplasma-addons kalarm sddm \
sddm-kcm kinfocenter kompare kamoso plasma-nm kwallet-pam libappindicator-gtk3 audiocd-kio plasma-browser-integration --needed

sudo systemctl enable sddm

echo
echo
echo


echo "Definir teclado português no sddm"

echo
echo
echo

echo "setxkbmap pt" | sudo tee -a /usr/share/sddm/scripts/Xsetup

echo
echo
echo

echo "Configurar o sddm"

echo
echo
echo

sudo cp -v /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf

echo
echo
echo

echo "Definir Numlock=On"

sleep 3

sudo nano /etc/sddm.conf

echo
echo
echo
