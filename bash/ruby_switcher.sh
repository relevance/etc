function use_ruby_186 {
 export MY_RUBY_HOME=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function use_jruby_116 {
# after installing JRuby:
# ln -s /opt/jruby-1.1.6/bin/jruby /opt/jruby-1.1.6/bin/ruby
 export MY_RUBY_HOME=/opt/jruby-1.1.6
 export GEM_HOME=~/.gem/jruby/1.8
 update_path
}
 
function use_ree_186 {
 export MY_RUBY_HOME=/opt/ruby-enterprise-1.8.6-20090201
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function use_ruby_191 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby_191
 export GEM_HOME=~/.gem/ruby/1.9
 update_path
}

function update_path {
 export PATH=$GEM_HOME/bin:$MY_RUBY_HOME/bin:$PATH
 export RUBY_VERSION="$(ruby -v | colrm 11)"
 display_ruby_version
}

function display_ruby_version {
 if [[ $SHELL =~ "bash" ]]; then
   echo "Using $RUBY_VERSION"
 fi
 # On ZSH, show it on the right PS1
 export RPS1=$RUBY_VERSION
}

use_ruby_186
