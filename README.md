<div align="center">

# Dotfiles

</div>

These are the heart and soul of my linux system.
Without these countless hours would go to waste.

These configurations provide the most at home environment for me to exist in.

For any Unixer do not copy these directly!! 
Instead take inspiration from these and apply them in your own dotfiles

## What are dotfiles ?
If you are coming from the world of Windows  , then you must be confused.

In layman's word , dotfiles refer to those files which configure the system in a Unix system. They are much more prevalent in Linux but are also found quite often in the MacOS world.

Most software/programs in the Unix world allow for granular control of their mechanics and working. Instead of GUI settings's menus (which already exist for countless programs). It is efficient and easier to configure any software using simple config files.

## Why are they named dotfiles ?
Most of the these files being configuration files , are usually hidden from the user. In the Unix world to hide a file/folder a simple `.` character has be the first character in the name.

Because of the same reason all of them are called dotfiles.

## What do they configure ?
In my case they configure a lot of the desktop , editor , browsers , mail clients etc.

In most cases they also define critical parts of the Operating System but need elevated privileges to edit.

This is a rough listing of the software/programs covered. I may not be using these programs at any given time , but the configuration stay static throughout the years.

- Alacritty (Terminal Emulator)
- xmonad , Awesome , BSPWM  , Openbox  , Qtile (Window Managers )
- xmobar , Polybar  , tint2 (Status Bars)
- Zathura (PDF Viewer)
- dmenu (Menu/App Launcher)
- dunst (Notification Manager)
- MPD (Music Player Daemon)
- NCMCPP ( Music Player Client)
- Neomutt ( Mail Client )
- picom (Dislay Compositor)
- slock (Display Locker)
- qutebrowser (Browser )
- sxhkd (Hotkey Daemon)
- X11 , Xprofile , Xinit (Theme settings for X Server)
- newsboat (RSS Feed Reader)
- bash ( Shell settings )

One of my major part of the dotfiles is `emacs` the text editor I use. It is essential to my workflow and it could and has replaced many of the above programs in the past.
As it is quite complicated and large , it is kept in a separate repository [Emacs](https://github.com/pspiagicw/pspiagicw-emacs)

## System Config

Above files control the user program and user settings , but I use Arch Linux or Gentoo Linux which requires configuring the internal settings of the Operating System for it to function properly.

These settings govern those internal settings.

### Xorg Settings
This includes setttings for *Nvidia Settings* or setting the correct DPI.

Thanks to NVIDIA , the driver does not detect my DPI of the screen correctly , thus all the text appears quite small then they should.

```
# /etc/X11/xorg.conf.d/90-monitor.conf
Section	"Monitor"
        # Technically can contain any name , but put your monitor configuration.
	Identifier 	"eDP-1"
        # Find the DPI using the xrandr-command. Confirm using `xdpyinfo | grep -B 2 resolution`
	DisplaySize	344	194
        # DPI automatically calculated in almost all cases.
	# Option		"DPI"	"96x96"
EndSection
```

This adds touch-to-tap or two-finger-scroll etc.

If using Desktop Environment , this is not needed as that would be controlled by the DE itself.

```
# /etc/X11/xorg.conf.d/70-synaptics.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
        Option "Tapping" "On"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertTwoFingerScroll" "on"
        Option "HorizTwoFingerScroll" "on"
EndSection
```

Use only if using Nvidia Driver exclusively! Don't use if going for Dual Graphics Card(Nvidia PRIME).
This allows brightness control(Although systemd-brightness can't restore the brightness on boot or hibernate.)
```
# /etc/X11/xorg.conf.d/40-nvidia-brightness.conf
Section	"Device"
	Identifier "Nvidia Card"
	Driver		"nvidia"
	Option		"RegistryDwords"	"EnableBrightnessControl=1"
EndSection
```


### FSTAB File
`/etc/fstab` file control which partition of the drive acts as which folder for the operating system.

The UUID are hidden for security reasons.



In most systems `/boot` directory contains the boot loader ,kernel and initramfs

The `/` directory is the root directory for the system.


The `/home` directory is the home directory where the user files are kept.My actual home folder is encrypted and thus not accessible unless unlocked using `dmcrypt` which is only possible with a Linux Kernel.
```
# /etc/fstab
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
# /dev/nvme0n1p5
UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	/         	ext4      	rw,relatime	0 1

# /dev/nvme0n1p1 LABEL=SYSTEM_DRV
UUID=XXXXXXXXX      	/boot     	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro	0 0

# /dev/sda2
UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	/home     	ext4      	rw,relatime	0 2

# /dev/sda5
UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	none      	swap      	defaults  	0 0

#/dev/sda3
UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX	/var		ext4		defaults	0 0
```

### MKINITCPIO
This configuration generates the /initramfs/ for my system. As the configuration is very big , only specific lines are present.

This adds the `resume` block thus allows the system to hibernate , but needs swap size more than the RAM size.
```
# /etc/mkinitcpio.conf
HOOKS=(systemd autodetect modconf block filesystems keyboard resume fsck)
```

### Pacman
Pacman Configuration is the most fundamental change.

Changes include
- Parallel Downloads - Allows for parallel downloads
- Chaotic AUR addition - Adding Chaotic AUR allows for installing packages from Chaotic Servers.
```
# /etc/pacman.conf
# Enabling Color
Color
# Parallel Downloads
ParallelDownloads = 10
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
```
