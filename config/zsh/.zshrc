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

## Nice prompt
#autoload -U promptinit
#promptinit
#
#prompt walters
##prompt bart

#source /usr/share/doc/pkgfile/command-not-found.zsh
