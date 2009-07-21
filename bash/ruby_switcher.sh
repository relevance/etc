export ORIGINAL_PATH=$PATH

function use_ruby_186 {
 export MY_RUBY_HOME=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function use_jruby_116 {
  echo "jruby 1.1.6 is deprecated.  Install jruby 1.2.0 by using install_jruby_120. Use it with use_jruby_120."
# after installing JRuby:
# ln -s /opt/jruby-1.1.6/bin/jruby /opt/jruby-1.1.6/bin/ruby
 export MY_RUBY_HOME=/opt/jruby-1.1.6
 export GEM_HOME=~/.gem/jruby/1.8
 update_path
}

function use_jruby {
 export MY_RUBY_HOME=~/.ruby_versions/jruby-1.3.1
 export GEM_HOME=~/.gem/jruby/1.8
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
  chmod +x ~/.ruby_versions/jruby-1.3.1/bin/{jruby,jgem,jirb} &&
  rm -rf ~/.ruby_versions/jruby-bin-1.3.1.zip &&
  use_jruby_120 && install_jruby_openssl && install_rake &&
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
 export MY_RUBY_HOME=~/.ruby_versions/ruby-enterprise-1.8.6-20090421
 export GEM_HOME=~/.gem/ruby/1.8
 update_path
}

function install_ree_20090421 {
  mkdir -p ~/tmp && mkdir -p ~/.ruby_versions &&
  pushd ~/tmp
  curl --silent -L -O http://rubyforge.org/frs/download.php/55511/ruby-enterprise-1.8.6-20090421.tar.gz &&
  tar xzf ruby-enterprise-1.8.6-20090421.tar.gz &&
  cd ruby-enterprise-1.8.6-20090421 &&
  ./installer -a $HOME/.ruby_versions/ruby-enterprise-1.8.6-20090421 --dont-install-useful-gems &&
  cd ~/tmp &&
  rm -rf ~/tmp/ruby-enterprise-1.8.6-20090421 ruby-enterprise-1.8.6-20090421.tar.gz &&
  use_ree_186 && install_rake &&
  popd
}

function use_ruby_191 {
 export MY_RUBY_HOME=~/.ruby_versions/ruby_191
 export GEM_HOME=~/.gem/ruby/1.9
 update_path
}

function install_ruby_191 {
  mkdir -p ~/tmp && mkdir -p ~/.ruby_versions &&
  pushd ~/tmp
  curl --silent -L -O ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.1-p0.tar.gz &&
  tar xzf ruby-1.9.1-p0.tar.gz &&
  cd ruby-1.9.1-p0 &&
  ./configure --prefix=$HOME/.ruby_versions/ruby_191 --enable-shared &&
  make && make install &&
  cd ~/tmp &&
  rm -rf ruby-1.9.1-p0.tar.gz ruby-1.9.1-p0 &&
  use_ruby_191 && install_rake &&
  popd
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

use_ruby_186
