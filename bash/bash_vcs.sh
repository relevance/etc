_bold=$(tput bold)
_normal=$(tput sgr0)

# http://gist.github.com/48207
function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function git_state_indicators {
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}

function git_divergence_indicator {
  git_status="$(git status 2> /dev/null)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
  echo $remote
}

function git_branch_and_indicator {
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo "${branch}$_bold$(git_state_indicators)$(git_divergence_indicator)$_normal"
  fi
}

__prompt_command() {
	local vcs vcs_indicator base_dir sub_dir ref last_command
	sub_dir() {
		local sub_dir
		sub_dir=$(stat -f "${PWD}")
		sub_dir=${sub_dir#$1}
		echo ${sub_dir#/}
	}

	git_dir() {
		base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
		if [ -n "$base_dir" ]; then
			base_dir=`cd $base_dir; pwd`
		else
			base_dir=$PWD
		fi
		sub_dir=$(git rev-parse --show-prefix)
		sub_dir="/${sub_dir%/}"
        ref=$(git_branch_and_indicator)
		vcs='git'
		vcs_indicator=''
		alias pull='git pull'
		alias commit='git commit -v -a'
		alias push='commit ; git push'
		alias revert='git checkout'
	}

	svn_dir() {
		[ -d ".svn" ] || return 1
		base_dir="."
		while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
		base_dir=`cd $base_dir; pwd`
		sub_dir="/$(sub_dir "${base_dir}")"
		ref=`svnversion`
		vcs="svn"
		vcs_indicator="(svn)"
		alias pull="svn up"
		alias commit="svn commit"
		alias push="svn ci"
		alias revert="svn revert"
	}

    	bzr_base_dir() {
        	# bzr root is really slow, so we simulate it
        	# with a bash script I modified frome here:
        	# http://unix.stackexchange.com/questions/6463/find-searching-in-parent-directories-instead-of-subdirectories
        	base_dir=$(pwd -P 2>/dev/null || command pwd)
        	while [ ! -e "$base_dir/.bzr" ]; do
            		# delete /* from the end of base_dir
            		base_dir=${base_dir%/*}
            		if [ "$base_dir" = "" ]; then return 1; fi
        	done
    	}

	bzr_dir() {
		bzr_base_dir || return 1
		if [ -n "$base_dir" ]; then
			base_dir=`cd $base_dir; pwd`
		else
			base_dir=$PWD
		fi
		sub_dir="/$(sub_dir "${base_dir}")"
		ref=$(bzr revno 2>/dev/null)
		vcs="bzr"
		vcs_indicator="(bzr)"
		alias pull="bzr pull"
		alias commit="bzr commit"
		alias push="bzr push"
		alias revert="bzr revert"
	}

	git_dir || svn_dir || bzr_dir

	if [ -n "$vcs" ]; then
		alias st="$vcs status"
		alias d="$vcs diff"
		alias up="pull"
		alias cdb="cd $base_dir"
		base_dir="$(basename "${base_dir}")"
        project="$base_dir:"
		__vcs_label="$vcs_indicator"
		__vcs_details="[$ref]"
		__vcs_sub_dir="${sub_dir}"
		__vcs_base_dir="${base_dir/$HOME/~}"
	else
		__vcs_label=''
		__vcs_details=''
		__vcs_sub_dir=''
		__vcs_base_dir="${PWD/$HOME/~}"
	fi

	last_command=$(history 5 | awk '{print $2}' | grep -v "^exit$" | tail -n 1)
	__tab_title="$project[$last_command]"
	__pretty_pwd="${PWD/$HOME/~}"
	hostname=`hostname -s`
  echo -e "\e]1;$__tab_title\007\c" # set tab title.  Doesn't work in Terminal.app
  echo -e "\e]2;$hostname::$__pretty_pwd" # set window title
}

PROMPT_COMMAND=__prompt_command
PS1='\a${__vcs_label}\[$_bold\]${__vcs_base_dir}\[$_normal\]${__vcs_details}\[$_bold\]${__vcs_sub_dir}\[$_normal\]\$ '

# Show the currently running command in the terminal title:
# http://www.davidpashley.com/articles/xterm-titles-with-bash.html
if [ -z "$TM_SUPPORT_PATH"]; then
  case $TERM in
    rxvt|*term|xterm-color)
      trap 'echo -e "\e]1;$project>$BASH_COMMAND<\007\c"' DEBUG # show currently executing command in tab title
    ;;
  esac
fi
