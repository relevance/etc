# Thanks to Geoffrey's peepcode for many of these
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gcap='git commit -v -a && git push'
alias gpp='git pull; git push'

# For when you are stuck between worlds...
alias gsd='git svn dcommit'
alias gsr='git svn rebase' 

# git auto completion - don't write your own when its already been done (better) and is in git-core
#   sudo port install git-core +bash_completion 
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi
