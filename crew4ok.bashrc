if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

PS1='\[\033[01;32m\]\u\[\033[01;36m\]\[\033[01;34m\][ \w ]\$\[\033[00m\] '

alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ll -a'

alias grep='grep --color=auto'

export EDITOR='vim'
