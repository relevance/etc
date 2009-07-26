export ORIGINAL_PATH=$PATH

function use_leopard_ruby {
 export MY_RUBY_HOME=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function use_jruby {
 export MY_RUBY_HOME=~/.ruby_versions/jruby-1.3.1
 export GEM_HOME=~/.gem/jruby/1.8
 alias ruby_ng="jruby --ng"
 alias ruby_ng_server="jruby --ng-server"
 update_path
}

function install_jruby {
  mkdir -p ~/.ruby_versions && pushd ~/.ruby_versions &&
  curl -O -L --silent http://dist.codehaus.org/jruby/1.3.1/jruby-bin-1.3.1.zip &&
  rm -rf jruby-1.3.1 &&
  jar xf jruby-bin-1.3.1.zip &&
  ln -sf ~/.ruby_versions/jruby-1.3.1/bin/jruby ~/.ruby_versions/jruby-1.3.1/bin/ruby &&
  ln -sf ~/.ruby_versions/jruby-1.3.1/bin/jgem ~/.ruby_versions/jruby-1.3.1/bin/gem   &&
  ln -sf ~/.ruby_versions/jruby-1.3.1/bin/jirb ~/.ruby_versions/jruby-1.3.1/bin/irb &&
  chmod +x ~/.ruby_versions/jruby-1.3.1/bin/{jruby,jgem,jirb,jrubyc} &&
  cd ~/.ruby_versions/jruby-1.3.1/tool/nailgun && make &&
  rm -rf ~/.ruby_versions/jruby-bin-1.3.1.zip &&
  use_jruby && install_jruby_openssl && install_rake &&
  popd
}

function use_jruby_120 {
 export MY_RUBY_HOME=~/.ruby_versions/jruby-1.2.0
 export GEM_HOME=~/.gem/jruby/1.8
 update_path
}

function install_jruby_120 {
  mkdir -p ~/.ruby_versions && pushd ~/.ruby_versions &&
  curl -O -L --silent http://dist.codehaus.org/jruby/1.2.0/jruby-bin-1.2.0.zip &&
  rm -rf jruby-1.2.0 &&
  jar xf jruby-bin-1.2.0.zip &&
  ln -sf ~/.ruby_versions/jruby-1.2.0/bin/jruby ~/.ruby_versions/jruby-1.2.0/bin/ruby &&
  ln -sf ~/.ruby_versions/jruby-1.2.0/bin/jgem ~/.ruby_versions/jruby-1.2.0/bin/gem   &&
  ln -sf ~/.ruby_versions/jruby-1.2.0/bin/jirb ~/.ruby_versions/jruby-1.2.0/bin/irb &&
  chmod +x ~/.ruby_versions/jruby-1.2.0/bin/{jruby,jgem,jirb} &&
  rm -rf ~/.ruby_versions/jruby-bin-1.2.0.zip &&
  use_jruby_120 && install_jruby_openssl && install_rake &&
  popd
}

function use_ree_186 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby-enterprise-1.8.6-20090610
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function install_ree_186 {
  mkdir -p ~/tmp && mkdir -p ~/.ruby_versions &&
  pushd ~/tmp
  curl --silent -L -O http://rubyforge.org/frs/download.php/58677/ruby-enterprise-1.8.6-20090610.tar.gz &&
  tar xzf ruby-enterprise-1.8.6-20090610.tar.gz &&
  cd ruby-enterprise-1.8.6-20090610 &&
  ./installer -a $HOME/.ruby_versions/ruby-enterprise-1.8.6-20090610 --dont-install-useful-gems &&
  cd ~/tmp &&
  rm -rf ~/tmp/ruby-enterprise-1.8.6-20090610 ruby-enterprise-1.8.6-20090610.tar.gz &&
  use_ree_186 && install_rake &&
  popd
}

function use_ruby_191 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby-1.9.1-p129
 export GEM_HOME=~/.gem/ruby/1.9
 update_path
}

function install_ruby_191 {
  install_ruby_from_source "1.9" "1" "129" &&
  use_ruby_191 && install_rake && popd
}


function use_ruby_186 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby-1.8.6-p369
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function install_ruby_186 {
  install_ruby_from_source "1.8" "6" "369" &&
  use_ruby_186 && install_rake && popd
}

function use_ruby_187 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby-1.8.7-p174
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function install_ruby_187 {
  install_ruby_from_source "1.8" "7" "174" &&
  use_ruby_187 && install_rake && popd
}

function install_ruby_from_source {
  local ruby_major=$1
  local ruby_minor=$2
  local patch_level=$3
  local ruby_version="ruby-$1.$2-p$patch_level"
  local url="ftp://ftp.ruby-lang.org/pub/ruby/$ruby_major/$ruby_version.tar.gz"

  mkdir -p ~/tmp && mkdir -p ~/.ruby_versions && rm -rf ~/.ruby_versions/$ruby_version &&
  pushd ~/tmp &&
  curl --silent -L -O $url &&
  tar xzf $ruby_version.tar.gz &&
  cd $ruby_version &&
  ./configure --prefix=$HOME/.ruby_versions/$ruby_version --enable-shared &&
  make && make install && cd ~/tmp &&
  rm -rf $ruby_version.tar.gz $ruby_version
}

function install_rake {
  gem install -q --no-ri --no-rdoc rake
}

function install_jruby_openssl {
  gem install -q --no-ri --no-rdoc jruby-openssl
}

function update_path {
 export PATH=$GEM_HOME/bin:$MY_RUBY_HOME/bin:$ORIGINAL_PATH
 export RUBY_VERSION="$(ruby -v | colrm 11)"
 display_ruby_version
}

function display_ruby_version {
 if [[ $SHELL =~ "bash" ]]; then
   echo "Using `ruby -v`"
 fi
 # On ZSH, show it on the right PS1
 export RPS1=$RUBY_VERSION
}

use_leopard_ruby
