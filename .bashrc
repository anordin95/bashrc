#------------SET COLOR VARIABLES FOR PS1-------#
# BLUE='\[\e[0;34m\]'
BLUE='\[\e[38;5;27m\]'
# CYAN='\[\e[0;36m\]'
CYAN='\[\e[38;5;87m\]'
# WHITE='\[\e[37;40m\]'
WHITE='\[\e[38;5;231m\]'
YELLOW='\[\e[38;5;226m\]'
RED='\[\e[38;5;196m\]'
RESET='\[\e[0m\]'
ORANGE='\[\e[38;5;208m\]' # 256 encoding scheme.

#------------END COLOR VARIABLES FOR PS1-------#

#------------SET PYENV CONFIGURATION-----------#
# BEGIN 1cff6a31-bb8f-4879-a2b4-8a6b3a7e8ed4
if [ -z "$PYENV_ROOT" ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
fi
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -x ~/.pyenv/bin/pyenv ]; then
  eval "$(~/.pyenv/bin/pyenv init -)"
  eval "$(~/.pyenv/bin/pyenv virtualenv-init -)"
fi
# END 1cff6a31-bb8f-4879-a2b4-8a6b3a7e8ed4
#------------END PYENV CONFIGURATION-----------#

#------------SET PROMPT------------------------#
# get current status of git repo
function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf "-"; return; else printf "["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf ">"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf "!"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf "+"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf "?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf "*"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf "-"; else printf ""; fi
  printf "]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
  # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

__export_ps1() {
  # export PS1="${ORANGE}[$(pyenv version-name)]${RESET} ${CYAN}\W${RESET} ${WHITE}\t ${RESET} (\033[33m\]\$(parse_git_branch)\[\033[31m\]\$(parse_git_dirty)\[\033[00m\]) \n \$ "
  export PS1="${ORANGE}[$(pyenv version-name)]${RESET} ${CYAN}\W${RESET} ${WHITE}\t ${RESET} ${YELLOW}\$(parse_git_branch)${RED}\$(parse_git_dirty)${RESET} \n \$ "
}
__export_ps1
export PROMPT_COMMAND='__export_ps1'

#------------END PROMPT------------------------#

#------------SET LOAD GIT COMPLETION-----------#
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
#------------END LOAD GIT COMPLETION-----------#

#------------SET COMMON ALIASES----------------#
alias gs='git status'
alias gb='git branch'
alias ga='git add'

alias ..='cd ..'

# enable coloring
alias ls='ls -Gp'
# set coloring scheme
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#------------END COMMON ALIASES----------------#

#------------SET DEFAULT EDITOR TO SUBLIME-----#
export EDITOR='sublime'
#------------END DEFAULT EDITOR TO SUBLIME-----#

#------------SET REQUIRED AIRFLOW CONFIG-------#
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
#------------END REQUIRED AIRFLOW CONFIG-------#

#------------SET PYTHONPATH HACK---------------#
# The airflow code in ~/software/dw/dw_manuf...
# relies on having asic-test available to be
# imported.
export PYTHONPATH=${PYTHONPATH}:~/software/asic-test
#------------END PYTHONPATH HACK---------------#





