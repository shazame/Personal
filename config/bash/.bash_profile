#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X server at login
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

# Launch ssh-agent at login to manage private keys
eval $(ssh-agent)

# MPD daemon start (if no other user instance exists
[ ! -s ~/.config/mpd/pid ] && mpd ~/.config/mpd/mpd.conf
