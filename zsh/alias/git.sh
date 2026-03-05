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
alias gfr="git fetch origin && git rebase \`default_remote_branch\`"
alias gfri="git fetch origin && git rebase -i \`default_remote_branch\`"
alias gg='git grep'
alias gl='git log'
alias gp='git push -u origin HEAD'
alias gpf='git push --force-with-lease'
alias gpu='git pull'
alias grc='git rebase --continue'
alias gr="git rebase \`default_remote_branch\`"

# These two are useful for locally reviewing latest changes on somebody else's PR (after they force push)
# "git reset hard upstream" - reset to tracking branch (fails if unstaged changes)
alias grhu='{ git diff --quiet || { echo "Error: unstaged changes present" >&2; false; } } && git reset --hard @{upstream}'
# "git fetch, reset hard upstream" - fetch then reset to tracking branch (fails if unstaged changes)
alias gfrhu='{ git diff --quiet || { echo "Error: unstaged changes present" >&2; false; } } && git fetch origin && git reset --hard @{upstream}'

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
