echo "Limpar sistema!"
rm -rfv ~/.cache/* 
rm -rfv ~/.local/share/akonadi/* 
rm -rfv ~/.local/share/Trash/* 
rm -rfv ~/.thumbnails/*
sudo rm -rfv /usr/share/doc/*
sudo rm -rfv /usr/share/info/*
sudo rm -rfv /usr/tmp/* 
sudo rm -rfv /var/cache/*
sudo rm -rfv /var/tmp/* 
#Não executar sudo rm -rf /tmp/* porque cria problemas na inicialização de programas na barra de ferramentas
echo "Limpar Pacman Cache"
sudo apt-get clean all
echo "Limpar Orfãos"
sudo apt-get autoremove
echo "Limpar Configurações"
sudo dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
echo "Sistema limpo!"

