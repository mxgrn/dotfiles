# Reload .zshrc
alias reload='source ~/.zshrc'

# Generic
alias ls='lsd'
alias l='lsd -l'
alias ll='lsd -al'
alias tree='lsd --tree'

alias psgrep='ps aux | grep $1'

alias tailf='tail -f -n200'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Capistrano
alias capd="cap deploy"
alias capdr="cap deploy:restart"

######
# tmux
######

# if there's a session to attach to, attach
alias tmux='tmux has-session 2>/dev/null && tmux attach || tmux'

alias t=tmuxinator

#####
# git
#####

# log
HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)%ar%C(reset)"
AUTHOR="%C(blue)<%an>%C(reset)"
REFS="%C(red)%d%C(reset)"
SUBJECT="%s"

alias gl='git log --pretty=tformat:"$HASH $RELATIVE_TIME $AUTHOR $SUBJECT" --graph'
alias glt='git log --pretty=format:"%C(yellow)%h $RELATIVE_TIME %Cblue%an%C(auto,green)%d %Creset%s" --graph --all'

# push
alias gp='git push'
alias gpu='git push --set-upstream'

# 'git patch' or something
alias gpa='git add . && git commit --amend --no-edit && git push -f'

# pull & fetch
alias gu='git pull'
alias gf='git fetch'

# diff
alias gd='git diff'
alias gdc='git diff --cached'

# merge & rebase
alias gm='git merge'

# commit
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa='git commit -v -a --amend'
alias gch='git cherry-pick'

# checkout
alias gco='git checkout'
# alias gom='git checkout master'
# alias goma='git checkout main'
alias gomu='git checkout master && git pull'
alias gos='git checkout staging'

# rebase
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

# branch
alias gb='git branch'
alias gba='git branch -a'
# deletes merged local branches
alias gbdm='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
# alias gbr='git for-each-ref --sort=-committerdate --format="%(committerdate:relative) -- %(refname:short)" refs/heads/ | head -n 20'
alias gbr='git for-each-ref --sort=-committerdate --format="%(committerdate:relative) -- %(refname:short) -> %(upstream:short)" refs/heads/ | head -n 20'
alias gbf='gbr | fzf | xargs git checkout'

# stash
alias gsp='git stash pop'
alias gs='git stash'

# misc
alias gsh='git show'
alias gR='git reset'
# recent branches
alias grh='git reset head~'
alias wip='git add . && git commit -a -m WIP'
alias gi='git init . && git add . && git commit -m "Initial commit"'

alias lg='lazygit'

# "Run" ssh links to clone repos:
# $ git@github.com:stefanjudis/dotfiles.git
# -> git clone git@github.com:stefanjudis/dotfiles.git
alias -s git="git clone"

################
# Elixir/Phoenix
################

alias mc='iex -S mix'
alias ms='mix setup'
alias mem='mix ecto.migrate'
alias mec='mix ecto.create'
alias md='mix deps.get'
alias mt='mix test'
alias mc='mix compile'
alias mf='mix format'
alias count_lines='find . -name "*.ex" -o -name "*.exs" | xargs wc -l'
