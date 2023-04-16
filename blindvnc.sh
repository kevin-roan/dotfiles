#!/bin/bash

sudo nmcli dev wifi connect "wifiapname"
ipadd=$(ip -4 addr show wlan1 | grep -oP '(?<==inet\s)\d+(.\d+){3}')
while true
do 
    espeak "$ipadd"
    sleep 2 
    espeak "again" 
done 

vncserver
