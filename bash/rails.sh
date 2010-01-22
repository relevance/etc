# ruby shortcuts
alias sc='script/console'
alias scprod='script/console production'
alias ss='script/server'
alias sg='script/generate'
alias sdb='script/dbconsole'

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
alias rmate='mate *.rb *.yml *.watchr Rakefile README Gemfile *.markdown *.md app bin config doc examples db lib public script spec test stories features'
# capistrano
alias csd='cap staging deploy'

