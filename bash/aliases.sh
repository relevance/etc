echo "[ executing aliases.sh ]"

# general shortcuts
alias c='cd '
alias mv='mv -i'
alias rm='rm -i'
alias :='cd ..'
alias ::='cd ../..'
alias :::='cd ../../..'
alias v='vmstat'
alias md=mkdir

# Need to do this so you use backspace in screen...I have no idea why
alias screen='TERM=screen screen'

# listing files
alias l='ls -al'
alias lt='ll -t'
alias la='lt -a'
alias lth='ll -t|head'
alias lh='ls -Shl | less'
alias tf='tail -f'
alias t500='tail -n 500'
alias t1000='tail -n 1000'
alias t2000='tail -n 2000'

# svn
alias sup='svn up'
alias sst='svn st'
alias sstu='svn st -u'
alias sci='svn ci -m'
alias sdiff='svn diff | colordiff'
alias smate='svn diff | mate && svn ci'
alias sadd="sst | grep '?' | cut -c5- | xargs svn add"

# git
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'

# git svn
alias gsr='git svn rebase' 
alias gsd='git svn dcommit' 

# editing shortcuts
alias m='mate'
alias e='emacs'
alias erc='e /etc/bashrc'
alias newrc='. /etc/bashrc'
alias rsync_nosvn="rsync --exclude=.svn -r "
alias rsync_novc="rsync --exclude=.svn --exclude=.git -r "

alias sourceit='. ~/src/scripts/profile.d/00_startup.sh'

# mate shortcuts
alias m8prof='m ~/src/scripts/profile.d/'

# ignore svn metadata - pipe this into xargs to do stuff
alias no_svn="find . -path '*/.svn' -prune -o -type f -print"

function findfile { find . -name \*$1\*
}
function orig { mv $1 orig-$1 ; cp orig-$1 $1; ls -lt $1 orig-$1
}
function ps? { ps -aux | grep -i $* | grep -v grep 
}

# Mac style apache control
# alias htstart='sudo /System/Library/StartupItems/Apache/Apache start'
# alias htrestart='sudo /System/Library/StartupItems/Apache/Apache restart'
# alias htstop='sudo /System/Library/StartupItems/Apache/Apache stop'

# Debian style apache control
alias htreload='sudo /etc/init.d/apache2 reload'
alias htrestart='sudo /etc/init.d/apache2 restart'
alias htstop='sudo /etc/init.d/apache2 stop'

# top level folder shortcuts
alias src='cd ~/src'
alias docs='cd ~/documents'
alias scripts='cd ~/src/scripts'

# ssh autocompletion
SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | \
cut -f 1 -d ' ' | \
sed -e s/,.*//g | \
uniq | \
egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh

alias h?="history | grep "
alias ps?="ps aux | grep "