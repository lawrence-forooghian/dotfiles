set -e

cd ~

for i in .tmux.conf .vimperatorrc .vimrc .zsh_profile .zshrc .inputrc .emacs .ackrc .gitconfig
do
	ln -s dotfiles/$i $i
done

ln -s dotfiles/.hammerspoon .

mkdir .ssh
cd .ssh
ln -s ../dotfiles/ssh_config config

git config --global core.excludesfile ~/dotfiles/global.gitignore

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install ack tmux tree vim reattach-to-user-namespace ncdu node emacs rbenv
brew cask install hammerspoon spotify iterm2
npm -g install instant-markdown-d

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

chsh -s /bin/zsh 

git config --global user.name "Lawrence Forooghian"
git config --global user.email "lawrence@dxw.com"

vim -c BundleInstall -c q -c q

cd .vim/bundle/command-t/ruby/command-t/ext/command-t
/usr/local/opt/ruby/bin/ruby extconf.rb
make install

open -a Hammerspoon

mkdir ~/.emacs_autosaves

echo "Now follow the steps in the additional_steps file."
