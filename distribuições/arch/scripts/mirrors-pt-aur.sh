#!/bin/bash

#Sítios espelho - Repositórios de programas

sudo reflector --verbose --country portugal --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy
