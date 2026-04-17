export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# zplug + Pure prompt
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Aliases
alias z="zellij"
alias vim="nvim"
alias love="/Applications/love.app/Contents/MacOS/love"
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
yt() { mpv --no-video "$1"; }

# Notes
alias notes="ls ~/Notes/"
alias inbox="nvim ~/Notes/inbox.md"

# History
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_all_dups

export PATH="$HOME/.local/bin:$PATH"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
