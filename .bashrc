# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
export PATH=~/.local/bin:~/.config/bin:~/.local/share/flutter/bin:~/.local/share/go/bin:$PATH
export MANPATH=$MANPATH:~/.local/share/man

# export BROWSER='qutebrowser'
export EDITOR='emacsclient -c'
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
alias ls='ls --color'
alias ll='ls -la --color'
alias la='ls -a --color'
export PS1="\[\e[32m\]\$\[\e[m\] "

alias nvim="TERM=xterm-24bit emacsclient -c --alternate-editor nano -nw "
export TUIR_URLVIEWER="urlscan"
# (cat ~/.cache/wal/sequences &)

export LFS=/mnt/lfs
export ANDROID_SDK_ROOT=~/.local/share/Android/Sdk
export GOPATH=~/.local/share/go
export FFF_OPENER="mimi"
export HUGO_BASE_DIR="~/documents/personalblog"


# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh



export GREEN="#50fa7b"
export ORANGE="#ffb86c"
export RED="#ff5555"
export WHITE="#f8f8f2"
