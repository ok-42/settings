alias ll='ls -al --color --group-directories-first'

alias ga='git add'
alias gb='git branch'
alias gbl='git branch --list'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdi='git diff --ignore-space-change'
alias gdt='git difftool'
alias gf='git fetch'
alias gg='git lg'
alias gl='git log -1'
alias gp='git pull'
alias gr='git reset --hard'
alias gs='git status'
alias gsn='git status --no-ahead-behind'
alias cb='git rev-parse --abbrev-ref HEAD'
alias rs='git config --get remote.origin.url'
alias rss='git remote show origin'

export MY_PROJECTS_PATH=~/projects
export MY_SETTINGS_PATH="$MY_PROJECTS_PATH"/settings
export MY_BASHRC_PATH="$MY_SETTINGS_PATH"/.bashrc

alias p='cd $MY_PROJECTS_PATH'
alias cls='clear'

# Recursive grep with coloured output and line numbers, excluding some folders
function greps() {

    # https://stackoverflow.com/a/806923
    REGEXP='^[0-9]+$'

    # Search for the text
    if ! [[ $1 =~ $REGEXP ]] ; then
        grep -nr --color=always --exclude-dir={.git,.idea,.ipynb_checkpoints,__pycache__,venv} --exclude=.grep_output\* "$1" | nl > .grep_output
        cat .grep_output

    # Read n-th line of the saved search results
    # and erase colours: https://stackoverflow.com/a/18000433
    else
        sed "$1q;d" .grep_output | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" > .grep_output_n
        awk '{print $2}' .grep_output_n | awk -F':' '{print $1 " -n" $2}' | xargs start notepad++
    fi
}

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

# pip
alias pf='pip freeze'
alias pi='pip install'
alias pl='pip list'
alias pu='pip uninstall'

# Python modules
alias pp='python -m pip install --upgrade pip'
alias pv='python -m venv venv'

export RED='\e[31m'
export GREEN='\e[32m'
export BLUE='\e[1;34m'
export RESET_COLOUR='\033[0m'

# Enable coloured output in PyLint. The tool uses built-in print function to output messages. The destination could
# be sys.stdout or colorama.AnsiToWin32 depending on TERM env variable. With TERM=xterm (my default), the output
# would be wrapped with colorama. On my Windows 10 / 11, it doesn't produce coloured output. I have to change TERM to
# keep the standard output and make it work. These links are ColorizedTextReporter.out and its ancestor class' method
# https://github.com/pylint-dev/pylint/blob/8776ba0808f807a8915d96c0901526d7c648ec34/pylint/reporters/text.py#L228
# https://github.com/pylint-dev/pylint/blob/8776ba0808f807a8915d96c0901526d7c648ec34/pylint/reporters/base_reporter.py#L43
export TERM=xterm-256color

# Activate the virtual environment for the current project and update the shell prompt to include the project name.
# This function first locates the project root directory, then checks for a virtual environment in that directory. If
# a virtual environment is found, it is activated, and the shell prompt is updated to include the name of the current
# project. Otherwise, an error message is displayed. This function should be run from within the project directory.
function a() {
    LOCAL_PATH=$(find_project_root)
    if [ -d "$LOCAL_PATH"/venv ]; then
        echo -e "Virtual environment found in ${BLUE}$LOCAL_PATH${RESET_COLOUR}"
        source_activate
        PROJECT_PATH=$(dirname "$VIRTUAL_ENV")
        PROJECT_NAME=$(basename "$PROJECT_PATH")
        export PS1="\012\[$BLUE\]($PROJECT_NAME) $ORIG_PS1"
    else
        echo -e "${RED}Virtual environment not found${RESET_COLOUR}"
    fi
}
alias da='deactivate'

alias v='vim $MY_BASHRC_PATH'
alias c='cat $MY_BASHRC_PATH'

function s() {
    # shellcheck disable=SC1090
    source $MY_BASHRC_PATH
    cp $MY_BASHRC_PATH ~/.bashrc
}

function m() {
    mkdir "$1" && cd "$1" || exit
}

function new() {
    if [[ -f $1 || -d $1 ]]; then
        echo Project "$1" already exists
        return
    else
        mkdir "$1"
        cd "$1" || return
        bash -i "$MY_PROJECTS_PATH"/settings/setup_project.sh
        pv && a && pp && pi wheel
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

# Navigate to the project root directory. This function should be run from within the project directory
function r() {
    PROJECT_ROOT=$(find_project_root)
    if [[ $PROJECT_ROOT == "/" ]]; then
        echo -e "${RED}Project root not found${RESET_COLOUR}"
    else
        cd "$PROJECT_ROOT" || exit
        echo -e "Project root: ${BLUE}$PROJECT_ROOT${RESET_COLOUR}"
    fi
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

# Open the current repository's GitHub page in Chrome. Written by ChatGPT
function gh() {
    local github_url
    github_url="$(rs)"
    github_url="${github_url/git@github.com:/https://github.com/}"
    github_url="${github_url/.git/}"
    if [[ -n $github_url ]]; then
        echo -e "Opening URL: ${BLUE}$github_url${RESET_COLOUR}"
        start chrome "$github_url"
    else
        echo -e "${RED}URL not found${RESET_COLOUR}"
    fi
}

# shellcheck disable=SC1090
source ~/git-prompt.sh

# shellcheck disable=SC2016
ORIG_PS1='\[\e[0;35m\]\t \[\e[0;32m\]\u@\h \[\e[0;33m\]\w\[\e[0;36m\] $(__git_ps1 "(%s)")\[\e[m\]\012$ '
PS1='\012'$ORIG_PS1

# shellcheck disable=SC1090
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# shellcheck disable=SC1090
if [ -f ~/.git-completion.bash ];
	then source ~/.git-completion.bash
fi
