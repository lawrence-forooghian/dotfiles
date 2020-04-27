DOTFILES_DIR="${HOME}/dotfiles"

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
DEFAULT_REMOTE_BRANCH="origin/master"
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
alias gr="git rebase ${DEFAULT_REMOTE_BRANCH}"
alias gri="git rebase -i ${DEFAULT_REMOTE_BRANCH}"
# This is "git review" - a thing to do before PRs, e.g. for finding TODOs. I
# haven’t included -p because sometimes it’s useful to just see the commits.
# But can add -p on when calling it
alias grv="git log ${DEFAULT_REMOTE_BRANCH}..HEAD"
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

export TMUXINATOR_CONFIG="${DOTFILES_DIR}/tmuxinator"
source "${DOTFILES_DIR}/vendor/tmuxinator.zsh"
# For starting multiple sessions in one go.
alias tnr="${DOTFILES_DIR}/bin/dotfiles-bundle-exec tmuxinator start --attach false"
