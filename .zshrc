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

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export ERL_AFLAGS="-kernel shell_history enabled"

# make <c-x><c-e> edit line in vim
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '^x^e' edit-command-line

# source /Users/mxgrn/Library/Preferences/org.dystroy.broot/launcher/bash/br

export PATH="/usr/local/opt/qt/bin:$PATH"

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   tmux
# fi

export PATH="/Users/mxgrn/.local/bin:$PATH"

# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# FZF preview colors (adapted from https://github.com/junegunn/fzf/blob/master/ADVANCED.md)
# export FZF_DEFAULT_OPTS='--color=border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99'

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export FLYCTL_INSTALL="/Users/mxgrn/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# source <(fzf --zsh)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH=$PATH:/Users/mxgrn/code/temp/roc_nightly-macos_apple_silicon-2023-03-31-424b4aa
export PATH=$PATH:/Users/mxgrn/.cargo/bin

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"

# Load local zshrc which will not be committed to git
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

export PATH="$HOME/.npm-global/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mxgrn/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mxgrn/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mxgrn/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mxgrn/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

PATH="$PATH":"$HOME/.local/scripts/"

# Enables tmux-sessionizer by <option-f>
# bindkey -s '\ef' 'tmux-sessionizer\n'

# Edit a script in neovim
ebin() {
  if [ -z "$1" ]; then
    echo "Usage: ebin <script>"
    return 1
  fi

  script=$(which "$1")
  nvim "$script"
}

export PATH="/Applications/Postgres.app/Contents/Versions/17/bin:$PATH"

# Fix editing the command line in vim (wouldn't work in tmux)
bindkey '^X^E' edit-command-line

# Move from (default) <c-s> to <c-]> to pause terminal output (resumes with <c-q>)
stty stop ^]

eval "$(mise activate zsh)"

# 2025-10-19 This breaks Elixir LS
# export MIX_OS_DEPS_COMPILE_PARTITION_COUNT=$(( $(sysctl -n hw.physicalcpu) / 2 ))
