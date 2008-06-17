_bold=$(tput bold)
_normal=$(tput sgr0)

__vcs_dir() {
	local vcs base_dir sub_dir ref
	sub_dir() {
		local sub_dir
		sub_dir=$(stat -f "${PWD}")
		sub_dir=${sub_dir#$1}
		echo ${sub_dir#/}
	}

	git_dir() {
		base_dir=$(git-rev-parse --show-cdup 2>/dev/null) || return 1
		if [ -n "$base_dir" ]; then
			base_dir=`cd $base_dir; pwd`
		else
			base_dir=$PWD
		 fi
		sub_dir=$(git-rev-parse --show-prefix)
		sub_dir="/${sub_dir%/}"
		ref=$(git-symbolic-ref -q HEAD || git-name-rev --name-only HEAD 2>/dev/null)
		ref=${ref#refs/heads/}
		vcs="git"
		alias pull="git pull"
		alias commit="git commit -a"
		alias push="commit ; git push"
		alias revert="git checkout"
	}

	svn_dir() {
		[ -d ".svn" ] || return 1
		base_dir="."
		while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
		base_dir=`cd $base_dir; pwd`
		sub_dir="/$(sub_dir "${base_dir}")"
		ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
		vcs="svn"
		alias pull="svn up"
		alias commit="svn commit"
		alias push="svn ci"
		alias revert="svn revert"
	}

	git_dir || svn_dir

	if [ -n "$vcs" ]; then
		alias st="$vcs status"
		alias d="$vcs diff"
		alias up="pull"
		alias cdb="cd $base_dir"
		base_dir="$(basename "${base_dir}")"
    WORKING_ON="$base_dir:"
		__vcs_prefix="($vcs)"
		__vcs_ref="[$ref]"
		__vcs_sub_dir="${sub_dir}"
		__vcs_base_dir="${base_dir/$HOME/~}"
	else
		__vcs_prefix=''
		__vcs_base_dir="${PWD/$HOME/~}"
		__vcs_ref=''
		__vcs_sub_dir=''
    WORKING_ON=""
	fi
}

PROMPT_COMMAND=__vcs_dir
PS1='\[\e]2;\h::${PWD/$HOME/~}\a\e]1;$WORKING_ON[$(history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g")]\a\]\u:$__vcs_prefix\[${_bold}\]${__vcs_base_dir}\[${_normal}\]${__vcs_ref}\[${_bold}\]${__vcs_sub_dir}\[${_normal}\]\$ '

# Show the currently running command in the terminal title:
# http://www.davidpashley.com/articles/xterm-titles-with-bash.html
if [ -z "$TM_SUPPORT_PATH"]; then
case $TERM in
  rxvt|*term|xterm-color)
    trap 'echo -e "\e]1;$WORKING_ON>$BASH_COMMAND<\007\c"' DEBUG
  ;;
esac
fi
