# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="mikeh"

plugins=( 
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# source $ZSH/oh-my-zsh.sh

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

alias cls='clear'

alias nnc='cd ~/.config/nvim && nvim .'
alias ncc='cd ~/.config && nvim .'
alias nzc='nvim ~/.zshrc'
alias n='nvim .'

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Aliases
#

alias yays='yay -S --noconfirm --needed'
eval "$(zoxide init zsh)"

# bun completions
[ -s "/home/raz/.bun/_bun" ] && source "/home/raz/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# add ~/.bin to path
export PATH="$HOME/.bin:$PATH"

# Created by `pipx` on 2023-11-21 01:50:24
export PATH="$PATH:/home/raz/.local/bin"

autoload -U bashcompinit
bashcompinit

eval "$(register-python-argcomplete pipx)"

# alias to run activate comand on .venv folder
alias ve="source .venv/bin/activate"

