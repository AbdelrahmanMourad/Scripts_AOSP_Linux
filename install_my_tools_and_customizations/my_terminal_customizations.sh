#!/bin/bash


# ======================================================================================================================
# My Terminal Customizations: customize the terminal appearance and behavior to my preferences:
# ======================================================================================================================    
# Set a custom prompt with colors and information
PS1='\[\e[0;32m\]\u@\h \[\e[0;34m\]\w\[\e[0m\] \$ ' # Green username@hostname, blue working directory
# Enable color support for 'ls' and add some handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Set a custom terminal title
echo -ne "\033]0;My Custom Terminal\007"
# Enable command auto-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
# Set a custom history size
HISTSIZE=10000 
HISTFILESIZE=20000
# Ignore duplicate commands in history
HISTCONTROL=ignoredups:erasedups
# Save multi-line commands as a single entry in history
shopt -s cmdhist
# Append to the history file, don't overwrite it
shopt -s histappend
# Enable case-insensitive tab completion
bind "set completion-ignore-case on"
# Enable recursive globbing (e.g., **/*.txt)
shopt -s globstar
# Set a custom terminal color scheme (Solarized Dark)
export TERM=xterm-256color
# Load custom aliases
if [ -f ~/Scripts_AOSP_Linux/install_tools/my_alias.sh ]; then
    source ~/Scripts_AOSP_Linux/install_tools/my_alias.sh
fi
# Load custom functions
if [ -f ~/Scripts_AOSP_Linux/install_tools/my_functions.sh ]; then
    source ~/Scripts_AOSP_Linux/install_tools/my_functions.sh
fi
# Set a custom greeting message
echo "Welcome to My Custom Terminal! Type 'help' to see available commands."
# End of customizations