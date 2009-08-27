function install_git_from_source {
  local version="$1"
  local man_url="http://kernel.org/pub/software/scm/git/git-manpages-$version.tar.bz2"
  local src_url="http://kernel.org/pub/software/scm/git/git-$version.tar.bz2"

  mkdir -p ~/tmp && pushd ~/tmp &&
  curl -O --silent $man_url && 
  sudo tar xj -C/usr/local/share/man -f git-manpages-$version.tar.bz2 &&
  rm -rf git-manpages-$version.tar.bz2 &&
  curl -O --silent $src_url &&
  tar xjf git-$version.tar.bz2 &&
  cd git-$version && find . -name "git-completion.bash" -exec cp {}  ~ \; &&
  ./configure && make && sudo make install && 
  cd ~/tmp && rm -rf git-$version git-$version.tar.bz2 && 
  popd
}

function install_git_completion {
  echo "source ~/.git-completion.bash" >> ~/.bash_profile
}
