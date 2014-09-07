if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

PS1='\[\e[01;33m\]\u\[\e[01;36m\]\[\e[01;34m\][ \w ]\$\[\e[00m\] '

alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ll -a'

alias grep='grep --color=auto'

export EDITOR='vim'
