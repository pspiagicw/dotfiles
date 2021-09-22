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
export PATH=$PATH:~/.local/bin:~/.config/bin:~/.local/share/flutter/bin
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
emacsman() {
    emacsclient -c -e "(let ((Man-notify-method 'bully)) (man \"$1\"))"
}

alias man=emacsman
