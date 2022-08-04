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

export MY_PROJECTS_PATH=~/projects
export MY_SETTINGS_PATH="$MY_PROJECTS_PATH"/settings
export MY_BASHRC_PATH="$MY_SETTINGS_PATH"/.bashrc

alias p='cd $MY_PROJECTS_PATH'
alias cls='clear'

if [ "$(uname -s)" == "Linux" ];
then
    alias python='python3'
else
    alias python='winpty python.exe'
    alias open='explorer .'
fi

alias jn='source $MY_SETTINGS_PATH/run_jupyter.sh'
alias pi='pip install'
alias pu='python -m pip install --upgrade pip'

alias a='source venv/Scripts/activate'
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

# shellcheck disable=SC1090
source ~/git-prompt.sh

PS1='\012\[\e[0;35m\]\t \[\e[0;32m\]\u@\h \[\e[0;33m\]\w\[\e[0;36m\] $(__git_ps1 "(%s)")\[\e[m\]\012$ '
