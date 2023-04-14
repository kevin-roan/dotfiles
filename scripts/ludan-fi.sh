#!/bin/sh

spin()
{
  spinner="/|\\-/|\\-"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep 1
    done
  done
}


echo "Script Made By Kevin Roan" 

echo "checking status..." 
##spin &
nmcli dev status 

echo "Turing wifi On..." 

nmcli radio wifi on 
echo "DONE..!"
echo "Searching for Nearby Networks..."
nmcli dev wifi list

echo "Enter AP name..."
read apname
sudo nmcli --ask dev wifi connect "$apname"


