# Repeat the last word in the command line by pressing ESC m (handy at renaming files)
bindkey "^[m" copy-prev-shell-word

# Better word separators for Z line editor (ctrl-w will become much more useful)
WORDCHARS=''

# No "zsh: sure you want to delete all the files in..." at rm
setopt rmstarsilent

export EDITOR='nvim'

# Re-enable emacs shortcats in vim mode
bindkey '^R' history-incremental-search-backward
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# If want to disable vim mode whatsoever:
# bindkey -e
