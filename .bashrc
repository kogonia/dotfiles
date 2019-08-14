# ~/.bashrc: executed by bash(1) for non-login shells. see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# unset this because of nasty OS X bug with annoying message:
# "dyld: DYLD_ environment variables being ignored because main executable (/usr/bin/sudo) is setuid or setgid"
# this is not correct, but Apple is too lazy to fix this
unset DYLD_LIBRARY_PATH

# add local bin path
PATH=$HOME/.bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
[ -d /usr/local/mysql/bin ] && PATH=/usr/local/mysql/bin:$PATH
[ -d /usr/local/share/npm/bin ] && PATH=/usr/local/share/npm/bin:$PATH

# don't put duplicate lines in the history
export HISTCONTROL=ignoreboth:erasedups
# set history length
HISTFILESIZE=1000000000
HISTSIZE=1000000

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# correct minor errors in the spelling of a directory component in a cd command
shopt -s cdspell
# save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist

# setup color variables
color_is_on=
color_red=
color_green=
color_yellow=
color_blue=
color_white=
color_gray=
color_bg_red=
color_off=
color_user=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_is_on=true
    color_black="\[$(/usr/bin/tput setaf 0)\]"
    color_red="\[$(/usr/bin/tput setaf 1)\]"
    color_green="\[$(/usr/bin/tput setaf 2)\]"
    color_yellow="\[$(/usr/bin/tput setaf 3)\]"
    color_blue="\[$(/usr/bin/tput setaf 6)\]"
    color_white="\[$(/usr/bin/tput setaf 7)\]"
    color_gray="\[$(/usr/bin/tput setaf 8)\]"
    color_off="\[$(/usr/bin/tput sgr0)\]"

    color_bold="\[$(/usr/bin/tput bold)\]"

    color_error="$(/usr/bin/tput setab 1)$(/usr/bin/tput setaf 7)"
    color_error_off="$(/usr/bin/tput sgr0)"

    # set user color
    case `id -u` in
        0) color_user=${color_bold}${color_red} ;;
        *) color_user=${color_bold}${color_green} ;;
    esac
fi

# some kind of optimization - check if git installed only on config load
PS1_GIT_BIN=$(which git 2>/dev/null)

if [ -f ~/.hostname ]; then
    LOCAL_HOSTNAME=`cat ~/.hostname`
else
    LOCAL_HOSTNAME=$HOSTNAME
fi

function prompt_command {
    local PS1_GIT=
    local PS1_VENV=
    local GIT_BRANCH=
    local GIT_DIRTY=
    local PWDNAME=$PWD

    # beautify working directory name
    if [[ "${HOME}" == "${PWD}" ]]; then
        PWDNAME="~"
    elif [[ "${HOME}" == "${PWD:0:${#HOME}}" ]]; then
        PWDNAME="~${PWD:${#HOME}}"
    fi

    # parse git status and get git variables
    if [[ ! -z $PS1_GIT_BIN ]]; then
        # check we are in git repo
        local CUR_DIR=$PWD
        while [[ ! -d "${CUR_DIR}/.git" ]] && [[ ! "${CUR_DIR}" == "/" ]] && [[ ! "${CUR_DIR}" == "~" ]] && [[ ! "${CUR_DIR}" == "" ]]; do CUR_DIR=${CUR_DIR%/*}; done
        if [[ -d "${CUR_DIR}/.git" ]]; then
            # 'git repo for dotfiles' fix: show git status only in home dir and other git repos
            if [[ "${CUR_DIR}" != "${HOME}" ]] || [[ "${PWD}" == "${HOME}" ]]; then
                # get git branch
                GIT_BRANCH=$($PS1_GIT_BIN symbolic-ref HEAD 2>/dev/null)
                if [[ ! -z $GIT_BRANCH ]]; then
                    GIT_BRANCH=${GIT_BRANCH#refs/heads/}

                    # get git status
                    local GIT_STATUS=$($PS1_GIT_BIN status --porcelain 2>/dev/null)
                    [[ -n $GIT_STATUS ]] && GIT_DIRTY=1
                fi
            fi
        fi
    fi

    # build b/w prompt for git and virtual env
    [[ ! -z $GIT_BRANCH ]] && PS1_GIT=" (git: ${GIT_BRANCH})"
    [[ ! -z $VIRTUAL_ENV ]] && PS1_VENV=" (venv: ${VIRTUAL_ENV#$WORKON_HOME})"

    # ip address
    local IP=$(hostname -I)
    IP=$(echo -en ${IP%?})
    IP=$(echo -en ${IP// /, })

    # curent time
    local TIME=$(date +%H:%M)

    # calculate prompt length
    local PS1_length=$((${#TIME}+${#IP}+${#LOCAL_HOSTNAME}+${#PWDNAME}+${#PS1_GIT}+${#PS1_VENV}+20))
    local FILL=

    # if length is greater, than terminal width
    if [[ $PS1_length -gt $COLUMNS ]]; then
        # strip working directory name
        PWDNAME="...${PWDNAME:$(($PS1_length-$COLUMNS+3))}"
    else
        # else calculate fillsize
        local fillsize=$(($COLUMNS-$PS1_length))
        FILL=$color_white
        while [[ $fillsize -gt 0 ]]; do FILL="${FILL}-"; fillsize=$(($fillsize-1)); done
        FILL="${FILL}${color_off}"
    fi

    if $color_is_on; then
        # build git status for prompt
        if [[ ! -z $GIT_BRANCH ]]; then
            if [[ -z $GIT_DIRTY ]]; then
                PS1_GIT=" (git: ${color_green}${GIT_BRANCH}${color_off})"
            else
                PS1_GIT=" (git: ${color_red}${GIT_BRANCH}${color_off})"
            fi
        fi

        # build python venv status for prompt
        [[ ! -z $VIRTUAL_ENV ]] && PS1_VENV=" (venv: ${color_blue}${VIRTUAL_ENV#$WORKON_HOME}${color_off})"
    fi

    # set new color prompt
    PS1=" [ ${color_yellow}${TIME}${color_off} ] [ ${color_blue}${LOCAL_HOSTNAME}${color_off} ] ${color_blue}${PWDNAME}${color_off}${PS1_GIT}${PS1_VENV} ${FILL} [ ${color_red}${IP}${color_off} ]\n [ ${color_user}${USER}${color_off} ] ➜ "

    # get cursor position and add new line if we're not in first column
    # cool'n'dirty trick (http://stackoverflow.com/a/2575525/1164595)
    # XXX FIXME: this hack broke ssh =(
#    exec < /dev/tty
#    local OLDSTTY=$(stty -g)
#    stty raw -echo min 0
#    echo -en "\033[6n" > /dev/tty && read -sdR CURPOS
#    stty $OLDSTTY
    echo -en "\033[6n" && read -sdR CURPOS
    [[ ${CURPOS##*;} -gt 1 ]] && echo "${color_error}↵${color_error_off}"

    # set title
    echo -ne "\033]0;${USER}@${LOCAL_HOSTNAME}:${PWDNAME}"; echo -ne "\007"
}

# set prompt command (title update and color prompt)
PROMPT_COMMAND=prompt_command

# extract archive
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# fawk
# Inspiration: http://serverfault.com/a/5551 (but basically rewritten)
function fawk() {
    USAGE="\
usage:  fawk [<awk_args>] <column_number>
        Ex: getent passwd | grep andy | fawk -F: 5
"
    if [ $# -eq 0 ]; then
        echo -e "$USAGE" >&2
        return
        #exit 1 # whoops! that would quit the shell!
    fi

    # bail if the *last* argument isn't a number (source:
    # http://stackoverflow.com/a/808740)
    last=${@:(-1)}
    if ! [ $last -eq $last ] &>/dev/null; then
        echo "FAWK! Last argument (awk field) must be numeric." >&2
        echo -e "$USAGE" >&2;
        return
    fi

    if [ $# -gt 1 ]; then
        # Source:
        # http://www.cyberciti.biz/faq/linux-unix-bsd-apple-osx-bash-get-last-argument/
        rest=${@:1:$(( $# - 1 ))}
    else
        rest='' # just to be sure
    fi
    awk $rest "{ print  \$$last }"
}

# bash completion
if [ -f /usr/local/bin/brew ]; then
    if [ -f `/usr/local/bin/brew --prefix`/etc/bash_completion ]; then
        . `/usr/local/bin/brew --prefix`/etc/bash_completion
    fi
fi

# bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# this is for delete words by ^W
tty -s && stty werase ^- 2>/dev/null

# golang
GOHOME="/usr/lib"
GOROOT="$GOPATH"
GOPATH="$GOHOME/go"
GOBIN="$GOPATH/bin"
GOMY="$GOPATH/src/go.code.local"

# php
PHPMY="/var/www/php/"
