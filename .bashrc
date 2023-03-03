alias ll='ls -al --color --group-directories-first'

alias ga='git add'
alias gb='git branch'
alias gbl='git branch --list'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdi='git diff --ignore-space-change'
alias gdt='git difftool'
alias gf='git fetch'
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

# https://stackoverflow.com/a/14799752
alias ccc='pygmentize -g -O style=colorful,linenos=1'
alias cc='highlight --out-format=xterm256 --line-numbers'

if [ "$(uname -s)" == "Linux" ];
then
    alias python='python3'
    alias source_activate='source "$LOCAL_PATH"/venv/bin/activate'
    alias t="tree -I 'venv|__pycache__'"
else
    alias python='winpty python.exe'
    alias open='explorer .'
    alias note='start notepad++'
    alias source_activate='source "$LOCAL_PATH"/venv/Scripts/activate'
fi

alias jn='source $MY_SETTINGS_PATH/run_jupyter.sh'
alias pi='pip install'
alias pu='python -m pip install --upgrade pip'

function a() {
    activate_venv
    if [ -z "$VIRTUAL_ENV" ]; then
        return
    fi
    PROJECT_PATH=$(dirname $VIRTUAL_ENV)
    PROJECT_NAME=$(basename $PROJECT_PATH)
    export PS1="\012\[\e[1;34m\]($PROJECT_NAME) $ORIG_PS1"
}
alias da='deactivate'

alias v='vim $MY_BASHRC_PATH'
alias c='cat $MY_BASHRC_PATH'

function s() {
    # shellcheck disable=SC1090
    source $MY_BASHRC_PATH
    cp $MY_BASHRC_PATH ~/.bashrc
}

function new() {
    if [[ -f $1 || -d $1 ]]; then
        echo Project "$1" already exists
        return
    else
        mkdir "$1"
        cd "$1" || return
        bash -i "$MY_PROJECTS_PATH"/settings/setup_project.sh
    fi
}

# Looks for venv directory in the current directory and goes up until venv is found or root reached
# If the virtual environment found, activates it
function activate_venv() {
    LOCAL_PATH=$(pwd);
    until [[ -d $LOCAL_PATH/venv || "$LOCAL_PATH" == "/" ]]; do
        LOCAL_PATH=$(dirname "$LOCAL_PATH")
    done
    if [ -d "$LOCAL_PATH"/venv ]; then
        echo Virual environment found in "$LOCAL_PATH"
        source_activate
    else
        echo Virual environment not found
    fi
}

# Prints project root (for me, it's a directory in ~/projects)
function find_project_root() {
    LOCAL_PATH=$(pwd)
    # Note that dirname prints path without trailing slash
    until [[ $(dirname "$LOCAL_PATH") == "$MY_PROJECTS_PATH" || "$LOCAL_PATH" == "/" ]]; do
        LOCAL_PATH=$(dirname "$LOCAL_PATH")
    done
    echo "$LOCAL_PATH"
}

function ch() {
  git log --format=format:'%ci' | awk -F' ' '{print $2}' | awk -F':' '{print $1}' | sort | uniq -c | awk -F' ' '{print $2 " " $1}' | column -c 5 -t -R 2
}

function chh() {
  FILE_NAME=$(date +%s).txt
  ch > "$FILE_NAME"
  python "$MY_SETTINGS_PATH"/stats.py "$FILE_NAME"
  rm "$FILE_NAME"
}

# shellcheck disable=SC1090
source ~/git-prompt.sh

export ORIG_PS1='\[\e[0;35m\]\t \[\e[0;32m\]\u@\h \[\e[0;33m\]\w\[\e[0;36m\] $(__git_ps1 "(%s)")\[\e[m\]\012$ '
PS1='\012'$ORIG_PS1

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

if [ -f ~/.git-completion.bash ];
	then source ~/.git-completion.bash
fi
