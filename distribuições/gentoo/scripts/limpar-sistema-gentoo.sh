echo "Limpar sistema!"
rm -rf ~/.cache/*
rm -rf ~/.local/share/akonadi/*
rm -rf ~/.local/share/Trash/*
rm -rf ~/.thumbnails/*
sudo rm -rf /.Trash*
sudo rm -rf /mnt/dados/.Trash-*
#sudo rm -rf /usr/portage/distfiles/*
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/info/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/tmp/*
# Não executar os seguintes comandos porque em /var está alguma informção útil(genlop por exemplo)
#sudo mv /var/cache/eix /tmp/
#sudo mv /var/cache/edb /tmp/
#sudo rm -rf /var/cache/*
#sudo mv /tmp/eix /tmp/edb /var/cache/
sudo mkdir /var/cache/revdep-rebuild
sudo rm -rf /var/tmp/*
#sudo chown -R portage:portage /var/cache/eix
#Não executar o seguinte porque cria problemas na inicialização de programas na barra de ferramentas
#sudo rm -rf /tmp/*
echo "Sistema Gentoo Limpo"
