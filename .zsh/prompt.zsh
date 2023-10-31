# Ideas from http://github.com/robbyrussell/oh-my-zsh

# Enable in-prompt calculations
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[blue]%})%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "
# ZSH_THEME_GIT_PROMPT_CLEAN=""

# get the name of the branch we are on
function git_prompt_info() {
  # displayes current dir in the title of terminal's tab/window
  # curdir=$(basename `pwd`)
  # echo -n -e "\033]0;$curdir\007"

  ref=$((git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null) || return

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function aws_session() {
  if [[ ! -z $AWS_VAULT ]]; then
    if [[ $(echo $AWS_VAULT | grep "dev") ]]; then
       COLOR=green
     elif [[ $(echo $AWS_VAULT | grep "int") ]]; then
       COLOR=yellow
     else
       COLOR=red
     fi

     #wrap colours between %{ %} to avoid weird terminal rendering: https://unix.stackexchange.com/questions/19498/understanding-colors-in-zsh
     echo "%{$fg[$COLOR]%}$AWS_VAULT%{$reset_color%} "
  fi
}

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/*}/(main|viins)/}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

parse_git_dirty () {
  if [[ $(git status  | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# For OSX the prompt is simpler than for Linux (when I also want to see the hostname and current time)
# Indicate git status in the prompt
if [[ $(uname) = "Darwin" ]]; then
  PROMPT='$(aws_session)%{$fg[green]%}➡%{$fg[green]%}%p %{$fg[cyan]%}%3d %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}'
  # PROMPT='$(git_prompt_info)%{$fg[green]%}➡ %{$reset_color%}'
else
  PROMPT='%{$fg[yellow]%}➡%{$fg[white]%}%m %{$fg[blue]%}%3d %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}% %{$reset_color%}'
  RPROMPT='%{$fg[green]%}%D{%H:%M}%{$reset_color%}'
fi
