DOTFILES_DIR="${HOME}/dotfiles"
export DOTFILES_ENV=$(cat ~/.dotfiles_env)

# Exports
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# brew bundle is very quiet otherwise
export HOMEBREW_VERBOSE=1

# Other shell niceties
bindkey -v
bindkey "^R" history-incremental-search-backward
# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# Set prompts - nabbed from http://www.edsel.nu/?p=203 until I get round to making one
autoload colors; colors
export PS1="%B[%{$fg[white]%}%n%{$reset_color%}%b@%B%{$fg[white]%}%m%b%{$reset_color%}:%~%B]%b "

# This apparently gives me git completion... erm.
autoload -U compinit && compinit

# Set up history.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# init rbenv
eval "$(rbenv init -)"

## Aliases

# Git aliases
default_remote_branch () {
  # If the origin/HEAD ref doesn’t exist, try creating it from the remote
  # repo’s head by running `git remote set-head origin --auto`
  git rev-parse --abbrev-ref origin/HEAD
}
alias ga="git add"
alias gab='git absorb'
alias gam='git commit --amend'
# "git branch history" - when checking out master to do something and then
# forgetting the name of my previous branch
alias gbh="git reflog | grep 'checkout:' | head -n 20"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gf='git fetch origin'
alias gg='git grep'
alias gl='git log'
alias gp='git push -u origin HEAD'
alias gpf='git push --force-with-lease'
alias gpu='git pull'
alias grc='git rebase --continue'
alias gr="git rebase \`default_remote_branch\`"
alias gri="git rebase -i \`default_remote_branch\`"
# This is "git review" - a thing to do before PRs, e.g. for finding TODOs. I
# haven’t included -p because sometimes it’s useful to just see the commits.
# But can add -p on when calling it
alias grv="git log \`default_remote_branch\`..HEAD"
# "git repository root" - cd to repo root
alias grr="cd \`git rev-parse --show-toplevel\`"
alias gs='git status'
alias gsh='git show'
alias gsu='git submodule update --init --recursive'

# Ruby aliases
alias be='bundle exec'
alias br='bundle exec rake'
alias bs='bundle exec rspec'
alias rc='bundle exec rubocop -a'
alias sf='bundle exec standardrb --fix'
alias rt="${DOTFILES_DIR}/bin/dotfiles-bundle-exec ripper-tags -R --exclude=vendor"

# iOS aliases
alias pi='bundle exec pod install'

# Universal aliases
alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias less='less -R' # colors

alias notes='tnr notes && tmux at -t notes'

# Set up resolution / refresh rate / scaling for my Samsung TV.
alias tv='displayplacer "id:5AB97DBE-C0BC-A81D-C1D2-7208ABDAD0D0+1A59AF89-04EA-AF12-1259-72A4A3F904C6 res:1920x1080 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0"'

# https://github.com/pyenv/pyenv#basic-github-checkout
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Base16 Shell
BASE16_SHELL="${DOTFILES_DIR}/vendor/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

base16_default-dark

export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin:${DOTFILES_DIR}/git-commands"
# When using PlantUML installed via Homebrew we want org-babel’s
# invocation of `java` to use the Homebrew-provided OpenJDK – TODO
# this is nasty because it essentially overrides the java command,
# which Homebrew doesn’t want to do.
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# This is suggested by the Firefox bootstrap script
export PATH="${HOME}/.mozbuild/git-cinnabar:$PATH"

export TMUXINATOR_CONFIG="${DOTFILES_DIR}/tmuxinator"
source "${DOTFILES_DIR}/vendor/tmuxinator.zsh"
# For starting multiple sessions in one go.
alias tnr="${DOTFILES_DIR}/bin/dotfiles-bundle-exec tmuxinator start --attach false"

# Open in the running Emacs server and then detach.
alias ec="emacsclient -n"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Run this after Homebrew upgrades Ruby.
alias rebuild_commandt_extension="cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t && /usr/local/opt/ruby/bin/ruby extconf.rb && make install"

# Auto-run `nvm use` after switching to a directory with a .nvmrc file
# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
