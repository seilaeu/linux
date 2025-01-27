#!/bin/bash
wanip=$(dig +short -6 myip.opendns.com aaaa @resolver1.ipv6-sandbox.opendns.com);
echo "$wanip" | while read ip; do
    echo "$ip $(whois "$ip" | awk ' /[Cc]ountry/{print $2}')"
done
