# Only for Mac OSX (Darwin)
if [[ $(uname) = "Darwin" ]]; then
  # export PATH=/usr/local/share/npm/bin:/usr/local/bin:$HOME/local/node/bin:$PATH
  export CC=gcc

  export NNN_PLUG='j:autojump;f:finder;o:fzopen;p:preview;d:diffs;t:nmount;v:imgview'

  # Put current directory into clipboard
  alias dirc='pwd | pbcopy'
  # Change to the directory which is in the clipboard
  alias dirp='cd `pbpaste`'

  # Different 'openners'
  alias o="open"

  # Postgres
  alias pgstart='brew services start postgresql'
  alias pgstop='brew services stop postgresql'
  alias pgrestart='brew services restart postgresql'

  # Remove duplicates in "Open with..."
  alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

  function play {
    afplay /System/Library/Sounds/$1.aiff
  }
fi
