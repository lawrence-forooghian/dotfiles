# Universal aliases
alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'

alias genclaco='ruby ~/dotfiles/generate_clang_complete.rb > .clang_complete'

# Work aliases
alias ssh2='ssh tm50-us-utility-2'
alias ssh2db="ssh tm50-us-utility-2 \"/data/texpert/current/script/dbconsole slave\""
alias ssh1='ssh tm50-us-utility-1'
alias ssh1db="ssh tm50-us-utility-1 \"/data/texpert/current/script/dbconsole slave\""
alias fsdiff="svn diff --diff-cmd=fmdiff"

# Work functions (from Simon)
function rakeall {
   pushd .
   for i in ~/deploy/current/*; do
       echo -e "\033[1;37m$i\033[0m"
	cd $i        
	if [ -e Rakefile ]; then
           rake "$@"
       fi
   done
   popd
}

function svnall {
   pushd .
   for i in ~/deploy/current/*; do
       echo -e "\033[1;37m$i\033[0m"
       cd $i
       svn "$@"
   done
   popd
}

# Exports
PATH=$HOME/bin:/opt/local/bin:/usr/local/mysql/bin:$HOME/android-sdk-mac_x86/tools:$HOME/android-sdk-mac_x86/platform-tools:/usr/local/sphinx/bin:$HOME/.rvm/bin:$PATH
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export DOTFILES_LOCALE=work

# RVM (standard)
[[ -s "/Users/lawrence/.rvm/scripts/rvm" ]] && source "/Users/lawrence/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Other shell niceties
bindkey -v

# Set prompts - nabbed from http://www.edsel.nu/?p=203 until I get round to making one
autoload colors; colors
export PS1="%B[%{$fg[white]%}%n%{$reset_color%}%b@%B%{$fg[white]%}%m%b%{$reset_color%}:%~%B]%b "

# This apparently gives me git completion... erm.
autoload -U compinit && compinit
