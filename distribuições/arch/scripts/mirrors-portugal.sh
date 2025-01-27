#!/bin/bash

#Sítios espelho - Repositórios de programas

sudo reflector --verbose -p http --country portugal --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
