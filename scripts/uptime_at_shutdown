#echo "$(date) - $(/usr/bin/uptime | sed 's/.*up \([^,]*\), .*/\1/')"  >> /media/linux/registo_de_uptime
#echo "$(date) - $(/usr/bin/uptime |awk -F, '{print $1,$2}' | sed 's/:/h, /g;s/^.*up */Uptime: /; s/ *[0-9]* user.*//;s/[0-9]$/&m/;s/ day. */d, /g')" >> /media/linux/registo_de_uptime
echo "$(date) - $(/usr/bin/uptime |awk -F, '{print $1,$2}' | sed 's/:/h, /g;s/^.*up */Uptime: /; s/ *[0-9]* user.*//;s/[0-9]$/&m/;s/ day. */d, /g')" >> /home/jribeiro/registo_de_uptime
