# Rails 2.x and 3.x shortcuts
function ss {
  if [ -e "./script/server" ]; then
    ./script/server $*
  elif [ -e "./script/rails" ]; then
    ./script/rails server $*
  fi
}

function sc {
  if [ -e "./script/console" ]; then
    ./script/console $*
  elif [ -e "./script/rails" ]; then
    ./script/rails console $*
  fi
}

function sdb {
  if [ -e "./script/dbconsole" ]; then
    ./script/dbconsole $*
  elif [ -e "./script/rails" ]; then
    ./script/rails dbconsole $*
  fi
}

# testing shortcuts
alias rt='rake --trace'
alias rtf='rake test:functionals --trace'
alias rti='rake test:integration --trace'
alias rtl='rake test:lib --trace'
alias rtp='rake test:plugins --trace'
alias rtu='rake test:units --trace'

alias rrcov='rake coverage:all:test'
alias rrrcovall='rake test:coverage:all:test'

alias rdm='rake db:migrate'
alias rdtp='rake db:test:prepare'
alias rdfl='rake db:fixtures:load'
alias rdr='rake db:rollback'
alias rroutes='rake routes'
alias mroutes='rroutes | mate'
alias rmate='mate *.rb *.yml *.watchr Rakefile README README* Gemfile *.markdown *.md app bin config doc examples db lib public script integration spec test stories features'
# capistrano
alias csd='cap staging deploy'
alias be='bundle exec'
