bash wget_git_prompt.sh
export OLD_FILES_PATH=~/old_files
mkdir $OLD_FILES_PATH
[ ! -f ~/.bashrc ] || mv ~/.bashrc $OLD_FILES_PATH
[ ! -f ~/.gitconfig ] || mv ~/.gitconfig $OLD_FILES_PATH
cp .bashrc .gitconfig ~
source .bashrc
