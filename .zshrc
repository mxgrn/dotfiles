export ZSH=$HOME/.zsh

# Comment out if you don't want to include non-generic/experimental stuff
# DOTFILES_ONLY_GENERIC=1

if [[ $DOTFILES_ONLY_GENERIC = 1 ]]; then
  # exclude filenames starting with underscore
  for config_file ($ZSH/[^_]*.zsh) source $config_file
  #find $ZSH -name "*.zsh" -and \! -name "_*" -exec source {} +
else
  for config_file ($ZSH/*.zsh) source $config_file
  #find $ZSH -name "*.zsh" -exec source {} +
fi

unset config_file # clean-up

### Some stuff gets install in /usr/local/sbin
PATH=$PATH:/usr/local/sbin:/Users/mxgrn/bin:/usr/local/smlnj/bin:/Users/mxgrn/bin/bc

export LANG=C

export ERL_AFLAGS="-kernel shell_history enabled"

# make <c-x><c-e> edit line in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# source /Users/mxgrn/Library/Preferences/org.dystroy.broot/launcher/bash/br

export PATH="/usr/local/opt/qt/bin:$PATH"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux
fi

export PATH="/Users/mxgrn/.local/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
# export PATH="/opt/homebrew/opt/postgresql@10/bin:$PATH"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# FZF preview colors (adapted from https://github.com/junegunn/fzf/blob/master/ADVANCED.md)
export FZF_DEFAULT_OPTS='--color=border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99'

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export FLYCTL_INSTALL="/Users/mxgrn/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH=$PATH:/Users/mxgrn/code/temp/roc_nightly-macos_apple_silicon-2023-03-31-424b4aa

export DIRENV_LOG_FORMAT=

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(direnv hook zsh)"
