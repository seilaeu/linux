# !/bin/bash

echo "Limpar o fedora"

rm -rf ~/.cache/*
rm -r ~/.config/chromium/Default/File\ System/*
rm -r ~/.local/share/akonadi/*
rm -r ~/.local/share/Trash/*
sudo rm -r /.Trash*
sudo rm -rf /usr/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/tmp/*
sudo rm -rf /tmp/*
