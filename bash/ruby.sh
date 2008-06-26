echo "[ executing ruby.sh ]"

# always load gems for ruby
export RUBYOPT=rubygems

complete -C ~/src/scripts/bin/rake_autocompletion.rb -o default rake

# rubygems shortcuts (http://stephencelis.com/archive/2008/6/bashfully-yours-gem-shortcuts)
alias gems='cd /opt/local/lib/ruby/gems/1.8/gems'
export GEMDIR=`gem env gemdir`
gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}
_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _gemdocomplete gemdoc

# ruby shortcuts
alias sc='script/console'
alias ss='script/server'
alias sg='script/generate'

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

# unit_record and autotest
alias autou='autotest'
alias autof='AUTOTEST=functional autotest'

# capistrano
alias csd='cap staging deploy'

# open rails code
alias m8rails125='mate ~/src/rails/rel_1-2-5'
alias m8rails126='mate ~/src/rails/rel_1-2-6'
alias m8rails201='mate ~/src/rails/rel_2-0-1'
alias m8rails202='mate ~/src/rails/rel_2-0-2'
alias m8railsedge='mate ~/src/rails/trunk'
alias m8railsstable='mate ~/src/rails/2-0-stable'

# shorten mongrel cluster commands
# example: cluster_start myapp
cluster_restart () { mongrel_rails cluster::restart -C /etc/mongrel_cluster/$1.yml;}
cluster_start () { mongrel_rails cluster::start -C /etc/mongrel_cluster/$1.yml;}
cluster_stop () { mongrel_rails cluster::stop -C /etc/mongrel_cluster/$1.yml;}