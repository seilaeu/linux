echo "Limpar sistema!"
rm -rf ~/.cache/* 
rm -rf ~/.local/share/akonadi/* 
rm -rf ~/.local/share/Trash/* 
rm -rf ~/.thumbnails/*
sudo rm -rf /.Trash* 
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/info/*
sudo rm -rf /usr/tmp/* 
sudo rm -rf /var/cache/*
sudo rm -rf /var/tmp/* 
sudo rm -rf /tmp/* 
echo "Cleaning Pacman Cache"
sudo pacman -Scc
sudo pacman -Rcsn $(pacman -Qqtd)
echo "Sistema limpo!"
