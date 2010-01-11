# Adapted from http://gist.github.com/31934
#   http://henrik.nyh.se/2008/12/git-dirty-prompt
#   http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
        RED="\[\033[0;31m\]"
     ORANGE="\[\033[0;33m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function git_branch_and_user {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${ORANGE}($(git_user_initials))${remote}${state}"
  fi
}

# Assumes you have set your initials in your Git config.
# 
# Use the following command to set your initials in your global Git config:
# 
#   git config --global user.initials 'jr'
function git_user_initials {
  git config --get user.initials || echo "-solo-"
}

function prompt_func() {
    previous_return_value=$?;
    prompt="${TITLEBAR}${COLOR_NONE}[${COLOR_NONE}\W${GREEN}$(git_branch_and_user)${COLOR_NONE}]${COLOR_NONE} "

    if test $previous_return_value -eq 0
    then
        PS1="${prompt}"
    else
        PS1="${prompt}${RED}${COLOR_NONE}"
    fi
}

PROMPT_COMMAND=prompt_func 
