#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# android studio blank screen fix

export _JAVA_AWT_WM_NONREPARENTING=1 exec $1

#userdefinedstuffs.
#you should run all the applications/scripts before executing the actual desktop environment.
#other wise shit won't work
dwmblocks &
nitrogen --restore 
# picom & # comporsitor
unclutter & #to auto hide cursor
autoshutdown &
# xrandr --output VGA-1 --primary
# xrandr --output LVDS1 --off # dont know why i wrote this.
exec dwm

