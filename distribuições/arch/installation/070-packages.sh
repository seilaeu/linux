#! /bin/bash

# Escritório

sudo pacman -S libreoffice-fresh libreoffice-fresh-pt --needed


# Multimedia

sudo pacman -S vlc pipewire wireplumber pipewire-pulse plasma-pa pulsemixer --needed

systemctl --user enable --now pipewire pipewire-pulse wireplumber

sudo pacman -S cdrdao cdrtools dvd+rw-tools gst-plugins-good gst-plugins-bad gst-plugins-ugly --needed


# Compressão e descompressão 

sudo pacman -S unzip unrar --needed


# Internet

sudo pacman -S firefox firefox-i18n-pt-pt wget youtube-dl --needed


# Cópias de segurança

yay -S spideroak-one

sudo pacman -S snapper grub-btrfs 

yay -S snapper-gui-git


# Firewall

sudo pacman -S ufw --needed

sudo ufw enable

sudo ufw status verbose

sudo systemctl enable ufw.service


# Sistema

sudo pacman -S cronie pkgfile pacman-contrib ncdu subversion sed reflector file which pkgstats --needed

sudo pkgfile -u

sudo systemctl start pkgstats.timer

sudo systemctl status pkgstats.timer

   
# Dicionários

sudo pacman -S aspell-pt --needed

yay -S hunspell-pt_pt mythes-pt_pt

