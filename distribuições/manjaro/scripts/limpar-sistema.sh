echo "Limpar sistema!"
rm -rf ~/.cache/* 
rm -rf ~/.local/share/akonadi/* 
rm -rf ~/.local/share/Trash/* 
rm -rf ~/.thumbnails/*
sudo rm -rf /.Trash* 
sudo rm -rf /media/audio/.Trash-1000/
sudo rm -rf /media/pessoal/.Trash-1000/
sudo rm -rf /media/linux/.Trash-1000/
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/info/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/tmp/* 
sudo rm -rf /var/cache/*
sudo rm -rf /var/tmp/* 
#Não executar o seguinte porque cria problemas na inicialização de programas na barra de ferramentas 
#sudo rm -rf /tmp/* 
echo "Cleaning Pacman Cache"
sudo pacman -Scc
sudo pacman -Rcsn $(pacman -Qqtd)
echo "Sistema limpo!"
