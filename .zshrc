# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export JDK_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
[ -d $HOME/.cargo/bin ] &&  PATH=$HOME/.cargo/bin:$PATH
[ -d $HOME/bin ] &&  PATH=$HOME/bin:$PATH
[ -d $GOBIN ] &&  PATH=$GOBIN:$PATH

#ZSH_THEME="jovial"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  zsh-history-enquirer

  git
  autojump
  urltools
  bgnotify
  zsh-autosuggestions
  jovial
  osx
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias config='/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

prompt_simple () {
    prompt_clear
    echo -en "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(prompt_char)\nPOWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()" >> ~/.p10k.zsh
}

prompt_default () {
    prompt_clear
    echo -en "POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir)\nPOWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status user host ip vpn_ip public_ip)" >> ~/.p10k.zsh
}

prompt_clear () {
    sed -e s/"POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(.*)"//g -i ~/.p10k.zsh
    sed -e s/"POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(.*)"//g -i ~/.p10k.zsh
}
