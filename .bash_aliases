# alias for dotfiles repository
alias config='/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}'

# grep
alias grep='grep --color'

# ls 
alias l1='ls -1'
alias ll='ls -ahlF'
alias la='ls -a'
alias l='ls -CF'
alias lt='ls -laht'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# apt
alias apg='sudo apt update; sudo apt upgrade'

# start a web server in current folder
alias www='python -m SimpleHTTPServer 8000'
