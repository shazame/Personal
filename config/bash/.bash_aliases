# Messing with ls
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add default confirmation when deleting
alias rm='rm -i'
alias clean='find . -name "*~"'

# Main used software aliases
alias za='zathura'
alias music='ncmpcpp --config .config/ncmpcpp/config'

# Fav dir shortcuts
alias go='cd ~/Eirbot/aversive.b_eirbot/projects/coupe2013/2A/'
alias goa='cd /home/david/aversive/aversive/modules/devices/control_system/filters/'
alias gopro='cd ~/ENSEIRB-MATMECA/S9/Project/'
alias goc='cd ~/ENSEIRB-MATMECA/S9/Cours/'
alias goi='cd ~/workspace/Internship/2A_AucklandUniversity/'
alias life='cd ~/Documents/GameOfLife/'

# Pacman convenient shorcuts
alias pacupg='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'

# vim: set syn=sh:
