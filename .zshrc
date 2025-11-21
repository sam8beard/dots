
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-bat)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# set neovim as default editor for remote sessions 
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

# Override aliases
unalias gcm
unalias ga
unalias gp
unalias gcb
unalias 2

# Custom aliases 
alias szrc="source ~/.zshrc"
alias nvl="nvim -c':e#<1'"
alias grn="go run ."
alias gah="git add ."
alias gs="git status"
alias ..="cd .."
alias 2="cd ../../"
# Custom functions
function ga {
	git add "$@"
}

function gcm {
	git commit -m "$@"
}

function gcb { 
	git checkout -b "$@"
} 
function gp {
	git push "$@"
}

function tga {
	tree "$@" --gitignore -a 
} 
function tg { 
	tree "$@" --gitignore
} 
# Initialize pure prompt
autoload -U promptinit; promptinit
# Configure pure prompt
zstyle :prompt:pure:path color white
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:branch color red
zstyle ':prompt:pure:prompt:*' color cyan
PURE_PROMPT_SYMBOL=">>"
prompt pure

# Configure autosuggest
bindkey '^ ' autosuggest-accept
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4eabb5,bold"

# Display welcome banner 
echo "\e[1m"
~/.welcome.sh | lolcat -p 2 -S 43 -t -F .05
echo "\e[1m"
echo "--------------------------------------------------------------------------------------"
echo "\e[1m"
date | lolcat -p 2 -S 20 -t -F .05
echo "\e[1m"
