alias relock='bundle install --relock'

# rubygems shortcuts (http://stephencelis.com/archive/2008/6/bashfully-yours-gem-shortcuts)
alias gems='cd $(gem env gemdir)/gems'

gemlite() {
  gem install $1 --no-rdoc --no-ri
}

# shorten mongrel cluster commands
# example: cluster_start myapp
cluster_restart () { mongrel_rails cluster::restart -C /etc/mongrel_cluster/$1.yml;}
cluster_start () { mongrel_rails cluster::start -C /etc/mongrel_cluster/$1.yml;}
cluster_stop () { mongrel_rails cluster::stop -C /etc/mongrel_cluster/$1.yml;}