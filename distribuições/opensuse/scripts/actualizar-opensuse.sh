sudo zypper ref && sudo zypper dup && echo
sudo zypper pa --orphaned && echo
sudo zypper pa --unneeded
sudo find / -not -path '/proc*' -not -path '/run*' -xtype l && echo
systemctl --failed && echo
journalctl -p 3 -b && echo
echo "                                Sistema actualizado!"
