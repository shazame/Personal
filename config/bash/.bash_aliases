# Adding color to this life
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Messing with ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add default confirmation when deleting
alias rm='rm -i'
alias clean='find . -name "*~"'

# Main used software aliases
alias za='zathura'
alias music='ncmpcpp --config .config/ncmpcpp/config'
alias blender='~/Logiciels/blender-2.61-linux-glibc27-i686/blender'
alias eclipse='/home/david/Logiciels/eclipse/eclipse'

# Jump back n directories at a time
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

# Aliases for git
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gd='git diff --color'

# vim: set syn=sh:
