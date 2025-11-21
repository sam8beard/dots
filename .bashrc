# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# removes duplicate paths
export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '!a[$0]++' | sed 's/:$//')

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi


#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more custom aliases and functions
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sbrc='source ~/.bashrc'
alias 1='cd ..'
alias 2='cd ../../'
alias gah='git add .'
alias gs='git status'
alias grl='git reflog'
alias list-funcs='typeset -f'

function gcm() { 
	git commit -m "$@"
} 
function gp() { 
	git push "$@"
} 
function tga() { 
	tree "$@" --gitignore -a
} 
function nvl() { 
	nvim -c ":e#<1"
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function docker_stop() {
  docker stop $(docker ps -aq | xargs) || echo "No containers to stop"
}
function docker_rm() {
  docker rm $(docker ps -aq | xargs) || echo "No containers to remove"
}
function docker_clean() {
  docker rm -f $(docker ps -aq | xargs) || echo "No containers to stop and remove"
}
function docker_swarm_clean() {
  docker service rm $(docker service ls -q) || echo "No services to stop and remove"
}
function docker_volume_clean() {
  docker volume rm -f $(docker volume ls -q | xargs) || echo "No volumes to remove"
}

alias docker_clean_volumes="docker_swarm_clean && docker_clean && docker network prune -f && docker volume prune -f && docker_volume_clean"

export OSH=$HOME/.oh-my-bash   # points to your symlink in ~/oh-my-bash
export OSH_THEME="agnoster"
OSH_PLUGINS=(git history web-search)
[ -f "$OSH/oh-my-bash.sh" ] && source "$OSH/oh-my-bash.sh"
# Display welcome banner 
echo -e "\e[1m"
~/.welcome.sh | lolcat -p 2 -S 43 -t -F .05
echo -e "\e[1m"
echo "--------------------------------------------------------------------------------------"
echo -e "\e[1m"
date | lolcat -p 2 -S 20 -t -F .05
echo -e "\e[1m"

