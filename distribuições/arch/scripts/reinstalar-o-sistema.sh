#!/bin/bash

pacman -Q | awk '{ print $1 }' > installed.tmp
for i in $(pacman -Qm | awk '{ print $1 }'); do
    cat installed.tmp | sed "s/^$i\$//;" > installed.tmp.1
    mv installed.tmp.1 installed.tmp
done
pacman -S --noconfirm `cat installed.tmp`
rm installed.tmp