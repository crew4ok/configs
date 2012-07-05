if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

PS1='\[\033[01;32m\]\u\[\033[01;36m\]\[\033[01;34m\][ \w ]\$\[\033[00m\] '

alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ll -a'
#alias make='LC_ALL=en_US.UTF-8 make'
#alias qtcreator='LC_ALL=en_US.UTF-8 qtcreator'
#alias gcc='LC_ALL=en_US.UTF-8 gcc'

export EDITOR='vim'
export LC_ALL=ru_RU.UTF-8
