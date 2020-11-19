# I already installed Xcode through Mac App Store, and then installed 1Password and Dropbox
# Probably would be best to install Homebrew first, which installs command line tools, then do this

set -e

cd ~

for i in .tmux.conf .vimperatorrc .vim .zsh_profile .zshrc .inputrc .emacs .ackrc .gitconfig
do
	ln -s dotfiles/$i $i
done

ln -s dotfiles/.hammerspoon .

# TODO: this already exists because generated a key to clone this repo
# mkdir .ssh
cd .ssh
ln -s ../dotfiles/ssh_config config

git config --global core.excludesfile ~/dotfiles/global.gitignore

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cd ~/dotfiles
brew bundle

npm -g install instant-markdown-d
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c BundleInstall -c q -c q

chsh -s /bin/zsh 

cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t
/usr/local/opt/ruby/bin/ruby extconf.rb
make install

open -a Hammerspoon

mkdir ~/.emacs_autosaves

cd ~/dotfiles
rbenv install
bundle install
rbenv rehash

npm -g install typescript

echo "Now follow the steps in the additional_steps file."
