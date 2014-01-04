# An impressive base zshrc is used: pacman -S grml-zsh-config

if [ -r ${ZDOTDIR:-${HOME}}/.zsh_aliases ]; then
    source ${ZDOTDIR:-${HOME}}/.zsh_aliases
fi

if [ -r ${ZDOTDIR:-${HOME}}/.zsh_marks ]; then
    source ${ZDOTDIR:-${HOME}}/.zsh_marks
fi

# Custom completion settings
fpath=(${ZDOTDIR:-${HOME}}/completion $fpath)
autoload -U compinit
compinit

# Prompt configuration (see: prompt -h grml)
# Available items:
#at, battery, change-root, date, grml-chroot,
#history, host, jobs, newline, path, percent, rc, rc-always, sad-smiley,
#shell-level, time, user, vcs

# Default prompt:
#zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs percent
#zstyle ':prompt:grml:right:setup' items sad-smiley

# My prompt:
zstyle ':prompt:grml:left:setup' items shell-level rc change-root user at host path vcs percent
zstyle ':prompt:grml:right:setup' items sad-smiley time battery

# Color configuration
# Yellow username
zstyle ':prompt:grml:left:items:user' pre '%F{yellow}'
# Blue time
zstyle ':prompt:grml:right:items:time' pre ' %F{blue}[ '
zstyle ':prompt:grml:right:items:time' post ']%f'

#source /usr/share/doc/pkgfile/command-not-found.zsh
