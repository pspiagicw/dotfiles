#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
if [ -f ~/.xprofile ]
then
    source ~/.xprofile
fi
exec xmonad
#exec startxfce4

# exec openbox-session
