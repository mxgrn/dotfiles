# Only for Mac OSX (Darwin)
if [[ $(uname) = "Darwin" ]]; then
  # export PATH=/usr/local/share/npm/bin:/usr/local/bin:$HOME/local/node/bin:$PATH
  export CC=gcc

  export BC_DEV_DOMAIN=mgorin.bloomco.de
  export BC_DEV_ADMIN_PASSWORD=insecure123
  export BC_DEV_ISSUER_PROC_SHARED_API_KEY=secret
  export BC_DEV_CLEARING_PROC_SHARED_API_KEY=secret
  export BC_DEV_KLARNA_CLIENT_TOKEN="eyJraWQiOiI4MzQ4ZDlmMS02NWVhLTQyZmEtYjhkNS1kOTJlNzMxYTYwZDQiLCJhbGciOiJSUzUxMiJ9.eyJ0ZW5hbnRfaWQiOiIxMDAwMDAwMCIsInRwcF9pZCI6IjEwMDAwMDAwIiwiY2xpZW50X2lkIjoiUEIxMDA5NTgiLCJqdGkiOiJjMTBhODdlZC1hZmFkLTQzODktODU2NS0zNDM1Yzk3NmUxYTAiLCJleHAiOjE2NzcwNjAwMDAsImlhdCI6MTY2MTE3NTc4N30.euWNoei8OMOjEGvASAhVNZ3SO2RdDNJ1sW5MP4_qldPWtLWB9eVDUu_K4aw50P2R-5ZZpzvRf8oqCt0lWwIyauulDlFuRR1rjV8GdL54p3CV5XMYORjks7jevleJV4JtXiiTxNKJbSf1S3SAx_zdOfmIqEh_WoUna3MLzLrUw1D5XMHtdQwnNjmxG3CVIbCy7j3IbNRGqfoORgTCi8hs2cbl1-SRQ_C023sBs3kHtMVFBjof14nTRRF4BpKNkkcOwu6tLp2hfeQSkBi2X3vD6nTcLSD3t1guZJ40BUdlENx52KJbe3m95LeLd0UrwiBit4EcKHLzRwWUCP0Om_3Pvg"

  # export BC_AWS_S3_ACCESS_KEY_ID=AKIAIZY6OSZL7KLUVXFQ
  # export BC_AWS_S3_SECRET_ACCESS_KEY=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
  # export BC_AWS_S3_BUCKET_NAME=app-store-development

  export BC_AWS_S3_ACCESS_KEY_ID=AKIASP3ECX6JJWMND4HE
  export BC_AWS_S3_SECRET_ACCESS_KEY=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
  export BC_AWS_S3_BUCKET_NAME=acqui-base-merchant-import-171471716242

  export SYSTEMTEST_DOMAIN=mgorin.bloomco.de
  export BC_DEV_ADMIN_PASSWORD=slick-brute-cobol-best
  export SYSTEMTEST_ISSUER_PROC_SHARED_API_KEY=secret
  export SYSTEMTEST_VAS_API_PASSWORD=yemen-redbird-session-scorpio

  export NNN_PLUG='j:autojump;f:finder;o:fzopen;p:preview;d:diffs;t:nmount;v:imgview'

  # export SENTRY_DSN=https://7d4c400c81f74c7aba28c47fb2552c55@o14538.ingest.sentry.io/1724374

  # export MERCHANT_IMPORT_BUCKET=acqui-base-merchant-import-171471716242
  # export ACQUIBASE_AWS_S3_ACCESS_KEY_ID=AKIASP3ECX6JJWMND4HE
  # export ACQUIBASE_AWS_S3_SECRET_ACCESS_KEY=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

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
