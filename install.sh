# TODO runnable from a web command
# TODO what if I've copied this over from another machine? Is any of this necessary?
# TODO this means that I need the dotfiles repo locally, also git-update-messages, check those both exist. We need to handle both circumstances - already exists, and doesn't exist (e.g. restoring from a backup at home vs a fresh machine at work).
# TODO create ~/.dotfiles_env
# TODO switch out the origin of dotfiles from HTTP to SSH at the end

set -e

# This script should be idempotent, and should succeed even if it’s already been
# run.

log() {
	echo "$1" 2>&1
}

set_up_homebrew() {
	pushd .

	if which brew >/dev/null; then
		log "Homebrew is already installed."
	else
		log "Installing Homebrew."

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	cd ~/dotfiles
	log "Installing Homebrew packages."
	brew bundle

	popd
}

install_config_files() {
	pushd .

	log "Installing config files."

	cd ~

	for i in .tmux.conf .vim .zsh_profile .zshrc .inputrc .emacs .ackrc .gitconfig .hammerspoon; do
		if [[ -e $i ]]; then
			log "~/$i already exists."
		else
			log "Creating symlink ~/$i."
			ln -s dotfiles/$i $i
		fi
	done

	if [[ -e .ssh ]]; then
		log "~/.ssh already exists."
	else
		log "Creating ~/.ssh."
		mkdir .ssh
	fi

	cd .ssh

	if [[ -e config ]]; then
		log "~/.ssh/config already exists."
	else
		log "Creating symlink ~/.ssh/config."
		ln -s ../dotfiles/ssh_config config
	fi

	log "Configuring Git’s global core.excludesfile to be ~/dotfiles/global.gitignore."
	git config --global core.excludesfile ~/dotfiles/global.gitignore

	popd .
}

set_up_node() {
	eval "$(fnm env)"

	log "Installing latest Node.js LTS."
	fnm install --lts

	for package in typescript wait-on npm-merge-driver; do
		log "Globally installing NPM package $package."
		npm install --location=global $package
	done
}

set_up_vim() {
	if [[ -e ~/.vim/autoload/plug.vim ]]; then
		log "vim-plug is already installed."
	else
		log "Installing vim-plug."

		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi

	log "Installing vim-plug packages."
	# The set nocompatible is required for the nerdcommenter package to be
	# initialised properly (normally we’d rely on vimrc to provide it)
	vim -u NONE -c 'set nocompatible' -c 'source ~/.vim/plugins.vim' -c PlugUpdate -c qa

	log "Installing CoC packages."
	# I would have preferred to use g:coc_global_extensions but since that just
	# takes effect on startup it means it doesn’t run synchronously and there’s
	# no way to quit once it’s complete, so hard to use in a script.
	vim -c 'CocInstall -sync coc-tsserver coc-prettier coc-eslint coc-sourcekit' -c 'qa'

	log "Rebuilding Command-T extension."
	~/dotfiles/bin/rebuild_commandt_extension
}

set_up_dotfiles_ruby() {
	pushd .

	log "Setting up dotfiles’s Ruby version and gems."
	cd ~/dotfiles
	# TODO slight problem here: replying no below makes it exit with 1
	# rbenv: /Users/lawrence/.rbenv/versions/2.7.0 already exists
	# continue with installation? (y/N)
	rbenv install
	bundle install
	rbenv rehash

	popd
}

set_up_git_update_messages() {
	pushd .

	log "Setting up git-update-messages’s Ruby version and gems."
	cd ~/code/git-update-messages
	rbenv install
	bundle install

	popd
}

create_local_gitconfig() {
	if [[ -e ~/.gitconfig_local ]]; then
		log "~/.gitconfig_local already exists."
	else
		log "What email address should be used for creating Git commits?"
		read git_email_address

		# https://stackoverflow.com/a/17093489
		tee ~/.gitconfig_local <<GITCONFIG
[user]
	email = ${git_email_address}
GITCONFIG

		log "Created ~/.gitconfig_local."
	fi
}

change_shell() {
	# https://stackoverflow.com/a/16375583
	current_shell=$(dscl . -read /Users/$USER UserShell)

	if [[ $current_shell == "UserShell: /bin/zsh" ]]; then
		log "User’s current default shell is already zsh."
	else
		log "Setting default shell to zsh."
		chsh -s /bin/zsh
	fi
}

create_emacs_autosaves_dir() {
	if [[ -e ~/.emacs_autosaves ]]; then
		log "~/.emacs_autosaves already exists."
	else
		log "Creating ~/.emacs_autosaves."
		mkdir ~/.emacs_autosaves
	fi
}

install_xcode() {
	if [[ $(xcodes installed | wc -l) -eq 0 ]]; then
		log "Xcode is already installed."
		xcodes install --latest --experimental-unxip
		# TODO do we need to do xcode-select?
	else
		log "Installing latest release version of Xcode."
	fi
}

# First we install Homebrew, which gives us the developer tools and Git.
set_up_homebrew
install_config_files
set_up_node
set_up_vim
set_up_dotfiles_ruby
set_up_git_update_messages
create_local_gitconfig
change_shell
install_xcode

open -a Hammerspoon

echo "Now follow the steps in the additional_steps file."
