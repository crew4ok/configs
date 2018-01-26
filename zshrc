# Path to your oh-my-zsh installation.
export ZSH=/home/crew4ok/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="clean-custom"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux common-aliases docker gradle)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias rm='rm'
alias vim='nvim'
export EDITOR='nvim'

source $HOME/.fzf-completion.zsh
source $HOME/.fzf-key-bindings.zsh

function toggle_vpn {
    local pid_file='/run/openconnect_gp.pid'
    if [ -f $pid_file ]; then
        cat $pid_file | xargs sudo kill
        sudo rm $pid_file
    else
        read -r -d '' HOSTS <<- EOM
        jenkins-vpc.vidible.tv
        jump-us-east.vidible.aolcloud.net
        main-virtual.docker.vidible.aolcloud.net
        docker-remote.docker.vidible.aolcloud.net
        artifactory-prod.vidible.aolcloud.net
        consul-stage.vidible.aolcloud.net
        kibana2.vidible.aolcloud.net
        kibana.vidible.aolcloud.net
        rabbitmq-stage.vidible.aolcloud.net
        rabbitmq.prod.vidible.aolcloud.net
        confluence.ops.aol.com
        elasticsearch-master.vidible.aolcloud.net
        duo.teamaol.com
        jira.ops.aol.com
        jenkins2.vidible.aolcloud.net
        svc.k8s-stage.vidible.aolcloud.net
        ash-m02.egress.aol.com
        o2-els-v5-prod.vidible.aolcloud.net
        o2-els-prod.vidible.aolcloud.net
EOM
        HOSTS=$(echo $HOSTS | tr '\n' ' ')
        sudo openconnect --protocol=gp -u aoksenenko -b gp-frr.remote.aol.com \
            -s "vpn-slice ${HOSTS} --verbose --dump" --pid-file=/run/openconnect_gp.pid
    fi
}

alias goto_jumphost='ssh -tt aoksen@ash-m02.egress.aol.com ssh -tt aoksen@jump.vidible.aolcloud.net'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/bin/async-profiler:$HOME/bin/flamegraph"

export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
