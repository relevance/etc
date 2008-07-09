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

# unit_record and autotest
alias autou='autotest'
alias autof='AUTOTEST=functional autotest'

# shorten mongrel cluster commands
# example: cluster_start myapp
cluster_restart () { mongrel_rails cluster::restart -C /etc/mongrel_cluster/$1.yml;}
cluster_start () { mongrel_rails cluster::start -C /etc/mongrel_cluster/$1.yml;}
cluster_stop () { mongrel_rails cluster::stop -C /etc/mongrel_cluster/$1.yml;}