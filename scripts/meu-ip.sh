#!/bin/bash
wanip=$(dig +short myip.opendns.com @resolver1.opendns.com);
echo "$wanip" | while read ip; do
    echo "$ip $(whois "$ip" | awk ' /[Cc]ountry/{print $2}')"
done
