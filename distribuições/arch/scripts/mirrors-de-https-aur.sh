#!/bin/bash

#Sítios espelho - Repositórios de programas

sudo reflector --verbose --country Germany -p https -a 1 -l 10 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy
