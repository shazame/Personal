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

# Automatically search the official repositories 
# when an unrecognized command is entered
source /usr/share/doc/pkgfile/command-not-found.bash

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

if [ -f ~/.bash_export ]; then
	. ~/.bash_export
fi

