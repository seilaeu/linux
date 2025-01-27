#!/bin/bash
wget https://github.com/aitorpazos/archlinux-libreoffice-breeze-icons/releases/download/2016.03.02/libreoffice-breeze-icons-2016.03.02.tar.gz &&
tar xvvf libreoffice-breeze-icons*tar.gz &&
sudo mv -v images_breeze* /usr/lib64/libreoffice/share/config/ &&
rm libreoffice-breeze-icons*tar.gz &&
echo 
echo "Finished!"
echo

