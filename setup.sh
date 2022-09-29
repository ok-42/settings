# https://stackoverflow.com/a/24716445
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/git-prompt.sh
export OLD_FILES_PATH=~/old_files
mkdir $OLD_FILES_PATH
[ ! -f ~/.bashrc ] || mv ~/.bashrc $OLD_FILES_PATH
[ ! -f ~/.gitconfig ] || mv ~/.gitconfig $OLD_FILES_PATH
cp .bashrc .gitconfig ~
source .bashrc
