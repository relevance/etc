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
alias ltr='ls -ltr'
alias lth='l -t|head'
alias lh='ls -Shl | less'
alias tf='tail -f -n 100'
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

# grep for a process
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# Mac style apache control
# TODO init this style of aliases for darwin arch
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

alias h?="history | grep "

# display battery info on your Mac
# see http://blog.justingreer.com/post/45839440/a-tale-of-two-batteries
alias battery='ioreg -w0 -l | grep Capacity | cut -d " " -f 17-50'
