#!/bin/bash
#to display connected display devices.
xrandr | grep " connected" | cut -f1 -d " "
echo "Enter Display Number: "
read devicenum
  var=("Enter Brightness Value:")
print_function(){
   echo "Display Brightness Changed Successfully..."
   xrandr --output $2 --brightness $1;
  }
if [ $devicenum == 1 ]; then 
  echo "Selected Device LVDS-1"
  echo $var
  read brvalue
  print_function "$brvalue" "LVDS-1" 
else 
  echo "Selected Device is HDMI-A-0"
  echo "Enter Brigthness Value:"
  read brvalue
  print_function "$brvalue" "HDMI-A-0" 
fi

