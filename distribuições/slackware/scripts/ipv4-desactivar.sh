#!/bin/bash

echo
sudo sysctl -w net.ipv4.conf.all.disable_policy=1
sudo sysctl -w net.ipv4.conf.default.disable_policy=1
sudo sysctl -w net.ipv4.conf.lo.disable_policy=1 
echo
