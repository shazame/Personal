proxy() {
		export http_proxy='http://147.210.183.243:3128'
		export https_proxy='https://147.210.183.243:3128'
}

mkcd() {
	mkdir $1 && cd $1
}

randpw() {
	< /dev/urandom tr -dc '123456789AZERTYUIOPQSDFGHJKLMWXCVBNazertyuiopqsdfghjklmwxcvbn!$%@?' | head -c $1; echo
}

# Filesystem Markers & Jump (http://alias.sh)
export MARKPATH=$HOME/.marks
function jump {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# git specific
rgc() {
    git commit -m"`curl -s http://whatthecommit.com/index.txt`"
}

# vim: set syn=sh:
