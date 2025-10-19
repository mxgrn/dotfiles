# Enable zsh auto-completion
autoload compinit && compinit

# Make autocompletion feel as bash-like as possible
setopt bash_auto_list
setopt no_auto_menu
setopt no_always_last_prompt

# From http://lethalman.blogspot.com/2009/10/speeding-up-zsh-completion.html
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# tg completion
_tg() {
  local -a commands
  commands=(
    'getWebhookInfo:Get webhook information for a Telegram bot'
    'setWebhook:Set webhook URL for a Telegram bot'
  )
  _describe 'command' commands
}
compdef _tg tg