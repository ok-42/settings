alias ll='ls -al --color --group-directories-first'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdi='git diff --ignore-space-change'
alias gg='git lg'
alias gl='git log -1'
alias gp='git pull'
alias gr='git reset --hard'
alias gs='git status'
alias cb='git rev-parse --abbrev-ref HEAD'
alias rs='git remote show origin'

export MY_PROJECTS_PATH=~/projects
export MY_SETTINGS_PATH="$MY_PROJECTS_PATH"/settings
export MY_BASHRC_PATH="$MY_SETTINGS_PATH"/.bashrc

alias p='cd $MY_PROJECTS_PATH'
alias cls='clear'

# https://stackoverflow.com/a/33469402
alias path='echo "$PATH" | tr ":" "\n"'

#https://stackoverflow.com/a/14799752
alias cc='pygmentize -g -O style=colorful,linenos=1'

if [ "$(uname -s)" == "Linux" ];
then
    alias python='python3'
    alias a='source venv/bin/activate'
    alias t="tree -I 'venv|__pycache__'"
else
    alias python='winpty python.exe'
    alias open='explorer .'
    alias a='source venv/Scripts/activate'
fi

alias jn='source $MY_SETTINGS_PATH/run_jupyter.sh'
alias pi='pip install'
alias pu='python -m pip install --upgrade pip'

alias da='deactivate'

alias v='vim $MY_BASHRC_PATH'
alias c='cat $MY_BASHRC_PATH'

function s() {
    # shellcheck disable=SC1090
    source $MY_BASHRC_PATH
    cp $MY_BASHRC_PATH ~/.bashrc
}

function new() {
  if [[ -f $1 || -d $1 ]];
  then
    echo Project "$1" already exists
    return
  else
    mkdir "$1"
    cd "$1" || return
    bash "$MY_PROJECTS_PATH"/settings/setup_project.sh
  fi
}

# Looks for venv directory in the current directory and goes up until venv is found or root reached
# If the virtual environment found, activates it
function activate_venv() {
  LOCAL_PATH=$(pwd);
  until [[ -d $LOCAL_PATH/venv || "$LOCAL_PATH" == "/" ]]; do
    LOCAL_PATH=$(dirname "$LOCAL_PATH");
  done;
  if [ -d "$LOCAL_PATH"/venv ]; then
    echo Virual environment found in "$LOCAL_PATH";
    source "$LOCAL_PATH"/venv/bin/activate;
  else
    echo Virual environment not found;
  fi
}

# shellcheck disable=SC1090
source ~/git-prompt.sh

PS1='\012\[\e[0;35m\]\t \[\e[0;32m\]\u@\h \[\e[0;33m\]\w\[\e[0;36m\] $(__git_ps1 "(%s)")\[\e[m\]\012$ '
