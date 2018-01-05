#### Variables

dir=~/dotfiles
olddir=~/dotfiles_old
files=".zshrc .vimrc .tmux.conf"

####

# change to dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old dir then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

source ~/.zshrc
source ~/.vimrc
source ~/.tmux.conf
