#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# We want color!
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#PS1='[\u@\h \W]\$ '
if [ "$color_prompt" = yes ]; then
	PS1='(\[\e[0;34m\]$(batlev)%\[\e[m\]) [\[\e[1;31m\]\t\[\e[m\]] [\[\e[0;33m\]\u\[\e[m\]:\[\e[1;33m\]\w\[\e[m\]]\n\[\e[0;32m\]$\[\e[m\] '
	PS1="[\[\e[1;35m\]\$?\[\e[m\]] "$PS1
else
	PS1='($(batlev)%) \u@\h \W\$ '
fi

export EDITOR=vim

# some aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias za='zathura'
alias go='cd ~/Eirbot/aversive.b_eirbot/projects/coupe2013/2A/'
alias gopro='cd ~/ENSEIRB-MATMECA/S8/Project/'

proxy() {
		export http_proxy='http://147.210.183.243:3128'
		export https_proxy='https://147.210.183.243:3128'
}

mkcd() {
	mkdir $1 && cd $1
}

# Automatically search the official repositories 
# when an unrecognized command is entered
source /usr/share/doc/pkgfile/command-not-found.bash

# For texlive
export MANPATH=$MANPATH:/usr/local/texlvie/2012/texmf/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlvie/2012/texmf/doc/info
export PATH=/usr/local/texlive/2012/bin/x86_64-linux:$PATH

# Disable the effect of /etc/profile.d/openssh-askpass.sh
# that pops up a qt4 windows for asking ssh passphrase
export SSH_ASKPASS=
