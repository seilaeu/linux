sudo reflector --verbose --country portugal -p https --age 2 --sort rate --save /etc/pacman.d/mirrorlist && echo && sudo pacman -Syu&& echo  && yay
echo
sudo pacman -R $(pacman -Qqtd)
sudo pacman -Scc && yay -Scc
