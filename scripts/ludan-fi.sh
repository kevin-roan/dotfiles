#!/bin/sh
echo "Script To Connect to Wifi Networks" 
echo "checking status..." 
nmcli dev status 
echo "Turing wifi On..." 
nmcli radio wifi on 
echo "DONE..!"
echo "Searching for Nearby Networks..."
nmcli dev wifi list
echo "Enter AP name..."
read apname
sudo nmcli --ask dev wifi connect "$apname"


