#! /bin/bash

echo
echo
echo

echo "Instalar ferramentas de programação"

echo
echo
echo

sudo pacman -S base-devel git --needed

echo
echo
echo

echo "Instalar o yay"

echo
echo
echo

git clone https://aur.archlinux.org/yay.git

echo
echo
echo

cd yay
makepkg -rsi
cd ..
rm -rf yay*

