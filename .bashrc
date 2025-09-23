#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v="nvim"
# PS1='[\u@\h \W]\$ '
export PS1=' \[\e[92m\]\\$\[\e[0m\] '
alias ls="exa"
export GOPATH=~/.go
export GOBIN=~/.go/bin
export PATH=$GOBIN:$PATH
alias ll="exa -al"
