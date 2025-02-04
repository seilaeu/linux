#!/bin/bash

# Procurar ligações quebradas

sudo find / -not -path '/proc*' -not -path '/run*' -xtype l


# Verificar se algum serviço do systemd falhou:

echo
echo
echo

systemctl --failed

echo
echo
echo

# Procurar erros de alta prioridade no journal do systemd:

journalctl -p 3 -b

echo
echo
echo
