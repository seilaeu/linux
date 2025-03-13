sudo dnf upgrade && echo
sudo dnf autoremove && echo
sudo dnf clean all && echo
sudo find / -not -path '/proc*' -not -path '/run*' -xtype l && echo
systemctl --failed && echo && journalctl -p 3 -b && echo
