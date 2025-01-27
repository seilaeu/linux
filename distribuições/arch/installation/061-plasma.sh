#! /bin/bash


# Plasma 5

sudo pacman -S plasma-desktop konsole kate dolphin kcalc ark okular gwenview 
sudo pacman -S ktorrent clementine kdeconnect breeze-gtk kde-gtk-config kmymoney 
sudo pacman -S k3b sddm sddm-kcm kinfocenter kompare khotkeys kamoso

sudo systemctl enable sddm

echo
echo
echo


# Teclado português no sddm

sudo bash -c 'echo "setxkbmap pt" >> /usr/share/sddm/scripts/Xsetup'

sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf

echo "Definir o tema breeze e o Numlock=On"

sleep 5

sudo nano /etc/sddm.conf
