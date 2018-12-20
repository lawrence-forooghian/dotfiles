set -e

cd ~

for i in .tmux.conf .vimperatorrc .vimrc .zsh_profile .zshrc .inputrc
do
	ln -s dotfiles/$i $i
done

ln -s dotfiles/.hammerspoon .

mkdir .ssh
cd .ssh
ln -s ../dotfiles/ssh_config config

git config --global core.excludesfile ~/dotfiles/global.gitignore

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install ack tmux tree vim watchman reattach-to-user-namespace ncdu node youtube-dl ffmpeg mas
brew cask install transmission vlc anki hammerspoon mactex spotmenu spotify skype whatsapp 1password dropbox virtualbox
npm -g install instant-markdown-d

mas account # `mas signin` doesn't work with 2FA
mas install 410628904 # Wunderlist
mas install 406056744 # Evernote
mas install 803453959 # Slack

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

chsh -s /bin/zsh 

git config --global user.name "Lawrence Forooghian"
git config --global user.email "lawrence.forooghian@gmail.com"

vim -c BundleInstall -c q -c q

cd .vim/bundle/command-t/ruby/command-t/ext/command-t
/usr/local/bin/ruby extconf.rb
make install

open -a SpotMenu
open -a Hammerspoon
