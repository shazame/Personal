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

# git specific
rgc() {
    git commit -m"`curl -s http://whatthecommit.com/index.txt`"
}

# vim: set syn=sh:
