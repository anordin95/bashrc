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
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;}__export_ps1"

#------------END PROMPT------------------------#

#------------SET SILENCE ZSH MAC OS CATALINA---#
export BASH_SILENCE_DEPRECATION_WARNING=1
#------------END SILENCE ZSH MAC OS CATALINA---#

#------------SET MAX OPEN FILES----------------#
ulimit -n 8192
#------------END MAX OPEN FILES----------------#

#------------SET LOAD GIT COMPLETION-----------#
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
#------------END LOAD GIT COMPLETION-----------#

#------------SET COMMON ALIASES----------------#
alias gs='git status'
alias gb='git branch'
alias ga='git add'
alias gc='git checkout'

alias k='kubectl'

alias ..='cd ..'
alias dw='cd ~/software/dw/dw_manufacturing/dw_manufacturing'
alias integration='cd ~/software/integration_test/integration_test'
alias dwf='cd ~/software/dw/dw_flow/'
alias btp='cd ~/software/butterfly_test_platform/butterfly_test_platform'
# alias dbt='cd ~/software/dw/dbt'
# enable coloring
alias ls='ls -Gp'

alias p='python'
alias s='sublime'
alias stop-dev-box='gcloud compute instances stop nordin-dev-big'
alias start-dev-box='gcloud compute instances start nordin-dev-big --zone us-east1-d'
alias ssh-dev-box='gcloud beta compute ssh --zone "us-east1-d" "nordin-dev-big" --project "butterfly-dw-prod" --tunnel-through-iap'
alias dev-box='start-dev-box && sleep 5 && ssh-dev-box'
# set coloring scheme
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export PED_OPEN_DIRECTORIES=1
#------------END COMMON ALIASES----------------#

#------------SET DEFAULT EDITOR TO SUBLIME-----#
export EDITOR='sublime'
#------------END DEFAULT EDITOR TO SUBLIME-----#

#------------SET REQUIRED AIRFLOW CONFIG-------#
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export SLUGIFY_USES_TEXT_UNIDECODE=yes
#------------END REQUIRED AIRFLOW CONFIG-------#

#------------SET PYTHONPATH HACK---------------#
# The airflow code in ~/software/dw/dw_manuf...
# relies on having asic-test available to be
# imported.
export PYTHONPATH=${PYTHONPATH}:~/code/software/asic-test
#------------END PYTHONPATH HACK---------------#
# BEGIN 18c0cbfd-1e2c-49fa-9b4b-eb17785f0ac3
export SLUGIFY_USES_TEXT_UNIDECODE=yes
export AIRFLOW_GPL_UNIDECODE=yes
# END 18c0cbfd-1e2c-49fa-9b4b-eb17785f0ac3