# Reload .zshrc
alias reload='source ~/.zshrc'

# ls-command: --color option is not standard on OSX, but with coreutils installed it'd work - hence the check
ls --color > /dev/null 2>&1
if [[ $? == 0 ]]; then
  alias ls='ls -F --color'
else
  alias ls='ls -G' # fallback to Darwin poor colors
fi

# Generic
alias l='exa -l'
alias ll='exa -al'
alias lll='ls -Al'
alias tree='exa --tree'

# alias l='ls -l'
# alias ll='ls -al'
# alias lll='ls -Al'

alias psgrep='ps aux | grep $1'

alias tailf='tail -f -n200'

alias k='kubectl'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

alias e='emacs &'

# Rails
alias r='rails'
alias rrg='rake routes | grep'

# rbenv
alias rr='rbenv rehash && echo "rbenv rehash"'

alias rmlogs='rm -f log/*.log'
alias rst='touch tmp/restart.txt'

alias killruby='sudo killall -9 ruby'

# Capistrano
alias capd="cap deploy"
alias capdr="cap deploy:restart"

# NGINX
alias nginxr="sudo nginx -s quit && sudo nginx"

# Ruby
alias retag='ctags -R --exclude=.svn --exclude=.git --exclude=log --exclude=tmp --exclude=extjs *'

# Bundler
alias b='bundle'
alias be='bundle exec'
alias bu='bundle update'

# git
HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)%ar%C(reset)"
AUTHOR="%C(blue)<%an>%C(reset)"
REFS="%C(red)%d%C(reset)"
SUBJECT="%s"

alias ga='git add'
alias gch='git cherry-pick'
alias gl='git log --pretty=tformat:"$HASH $RELATIVE_TIME $AUTHOR $SUBJECT" --graph'
# alias gl='git log --pretty=format:"%C(auto)%h %C(auto)%d %Creset%s %Cblue%an" --graph'
alias gla='git log --pretty=format:"%C(auto)%h %C(auto)%d %Creset%s %Cblue%an" --graph --all'
alias gt="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%C(auto,green)%d %Creset%s' --date=short --graph --all"
alias gp='git push'
alias gpu='git push --set-upstream'
alias gu='git pull'
alias gf='git fetch'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git merge'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa='git commit -v -a --amend'
alias gco='git checkout'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
# deletes merged local branches
alias gbdm='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gcl='git clone'
alias gsp='git stash pop'
alias gs='git stash'
# alias gt='git log --oneline --decorate --all --graph'
alias gsh='git show'
alias gx='gitx --all'
alias gR='git reset'
alias gbr='git for-each-ref --count=15 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gbf='gbr | fzf | xargs git checkout'
alias grh='git reset head~'
alias grm='git rebase master'
alias gom='git checkout master'
alias gomu='git checkout master && git pull'

alias wip='git add . && git commit -a -m WIP'
alias lg='lazygit'

# Misc
alias f='fg'

# Elixir/Phoenix
alias mc='iex -S mix'
alias ms='mix phoenix.server'
alias mm='mix ecto.migrate'
alias md='mix deps.get'
alias mt='mix test'
alias mc='mix compile'
alias mf='mix format'

# "Run" ssh links to clone repos
# $ git@github.com:stefanjudis/dotfiles.git
# -> git clone git@github.com:stefanjudis/dotfiles.git
alias -s git="git clone"

# Yadm
alias ya='yadm add'
alias ych='yadm cherry-pick'
alias yl='yadm log --pretty=tformat:"$HASH $RELATIVE_TIME $AUTHOR $SUBJECT" --graph'
# alias gl='yadm log --pretty=format:"%C(auto)%h %C(auto)%d %Creset%s %Cblue%an" --graph'
alias yla='yadm log --pretty=format:"%C(auto)%h %C(auto)%d %Creset%s %Cblue%an" --graph --all'
alias yt="yadm log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%C(auto,green)%d %Creset%s' --date=short --graph --all"
alias yp='yadm push'
alias ypu='yadm push --set-upstream'
alias yu='yadm pull'
alias yf='yadm fetch'
alias yd='yadm diff'
alias ydc='yadm diff --cached'
alias ym='yadm merge'
alias yc='yadm commit -v'
alias yca='yadm commit -v -a'
alias ycaw='yadm add . && git commit -v -a -m WIP'
alias ycaa='yadm commit -v -a --amend'
alias yco='yadm checkout'
alias yr='yadm rebase'
alias yrc='yadm rebase --continue'
alias yra='yadm rebase --abort'
alias yb='yadm branch'
alias yba='yadm branch -a'
# deletes merged local branches
alias ybdm='yadm branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias ysp='yadm stash pop'
alias ys='yadm stash'
# alias gt='yadm log --oneline --decorate --all --graph'
alias ysh='yadm show'
alias yx='yadmx --all'
alias yR='yadm reset'
alias ybr='yadm for-each-ref --count=15 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias ybf='ybr | fzf | xargs yadm checkout'
alias yrh='yadm reset head~'
alias yrm='yadm rebase master'
alias yom='yadm checkout master'
alias yomu='yadm checkout master && git pull'

