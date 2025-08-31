sudo reflector --verbose --country portugal -p https --age 2 --sort rate --save /etc/pacman.d/mirrorlist && echo && sudo pacman -Syu && echo && yay && echo 
sudo pacman -R $(pacman -Qqtd) && echo 
paccache -rk 3 && paccache -ruk 0 && echo 
sudo find / -not -path '/proc*' -not -path '/run*' -xtype l && echo 
systemctl --failed && echo 
journalctl -p 3 -b && echo
echo "                                Sistema actualizado!"
