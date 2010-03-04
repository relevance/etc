alias relock='bundle install --relock'

# rubygems shortcuts (http://stephencelis.com/archive/2008/6/bashfully-yours-gem-shortcuts)
alias gems='cd $(gem env gemdir)/gems'
export GEMDIR=`gem env gemdir`
gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}
_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _gemdocomplete gemdoc

gemlite() {
  gem install $1 --no-rdoc --no-ri
}

# shorten mongrel cluster commands
# example: cluster_start myapp
cluster_restart () { mongrel_rails cluster::restart -C /etc/mongrel_cluster/$1.yml;}
cluster_start () { mongrel_rails cluster::start -C /etc/mongrel_cluster/$1.yml;}
cluster_stop () { mongrel_rails cluster::stop -C /etc/mongrel_cluster/$1.yml;}