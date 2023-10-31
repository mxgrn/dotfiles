extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Start Rails/Phoenix server
function s {
    if [ -e Gemfile ]; then
        be rails server $@
    else
        mix phx.server
    fi
}

# Start Rails/Phoenix console
function c {
    if [ -e Gemfile ]; then
        be rails console $@
    else
        iex -S mix
    fi
}

# git
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}
compdef g=git # autocompletion

# yadm
function y {
  if [[ $# > 0 ]]; then
    yadm $@
  else
    yadm status
  fi
}

function git-nuke {
  git branch -D $1 && git push origin :$1
}

# cd that wraps arguments into quotes
function cdd {
  cd "$*"
}
