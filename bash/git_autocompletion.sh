# git auto completion - don't write your own when its already been done (better) and is in git-core
#   sudo port install git-core +bash_completion 
if [ -f /opt/local/etc/bash_completion ]; then
   . /opt/local/etc/bash_completion
   complete -o default -o nospace -F _git g
fi
