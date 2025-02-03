#! /bin/bash

sudo pacman -S xfce4 xfce4-whiskermenu-plugin leafpad lightdm lightdm-gtk-greeter numlockx  --needed
sudo pacman -S thunar-archive-plugin ristretto mousepad atril galculator gvfs gvfs-mtp --needed
sudo pacman -S xfce4-taskmanager xfce4-pulseaudio-plugin alacarte --needed

sudo systemctl enable lightdm 

yay -S mugshot 
