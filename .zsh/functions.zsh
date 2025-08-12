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

function gom() {
  if git rev-parse --verify main >/dev/null 2>&1; then
    git checkout main
  elif git rev-parse --verify master >/dev/null 2>&1; then
    git checkout master
  else
    echo "Neither 'main' nor 'master' branch found"
    return 1
  fi
}

# Start Rails/Phoenix server
function s {
    if [ -e Gemfile ]; then
        be rails server $@
    else
        iex -S mix phx.server
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

function git-nuke {
  git branch -D $1 && git push origin :$1
}

# cd that wraps arguments into quotes
function cdd {
  cd "$*"
}

# docker remote
# Examples:
#   dr ketoketo
#   dr ketoketo 2
#   dr ketoketo 2 staging
function dr {
  DOCKER_HOST=ssh://app${2:-1} docker exec -ti $1_${3:-prod} /app/bin/$1 remote
}

function dl {
  DOCKER_HOST=ssh://app${2:-1} docker logs -f --tail 100 $1_${3:-prod}
}

function ds {
  DOCKER_HOST=ssh://app${2:-1} docker exec -ti $1_${3:-prod} bash
}

function sapp {
  ssh app$1
}
