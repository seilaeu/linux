echo "Limpar sistema!"
rm -rf ~/.cache/*
rm -rf ~/.local/share/Trash/* 
sudo rm -rf /.Trash* 
sudo rm -rf /mnt/dados/.Trash-*
sudo rm -rf /usr/tmp/* 
sudo rm -rf /var/cache/*
sudo rm -rf /var/tmp/* 
echo "Cleaning Pacman Cache"
sudo pacman -Scc
sudo pacman -Rcsn $(pacman -Qqtd)
echo "Sistema limpo!"
