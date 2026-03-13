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

## GitHub

# "GitHub PR description" — convert a commit message into a PR description,
# i.e. unwrap hard-wrapped lines, add backticks around code identifiers, and
# convert [1]-style numbered references into inline Markdown links. Uses an
# LLM because identifying code identifiers and distinguishing references from
# other bracket syntax (e.g. array indices) are both fuzzy tasks.
# Usage: gh-pr-desc <commit-sha>
gh-pr-desc() {
  local msg
  msg=$(git log -1 --format='%B' "${1:?Usage: gh-pr-desc <commit-sha>}")
  if [ -z "$msg" ]; then
    echo "No commit message found" >&2
    return 1
  fi
  echo "$msg" | claude --print -p "Reformat this Git commit message for use as a GitHub pull request description. Do not change the wording; only apply the following formatting transformations: unwrap hard-wrapped lines into flowing paragraphs, collapse loose lists (blank lines between items) into tight lists, add backticks around code identifiers (function names, variables, file paths, CLI flags, etc.) where appropriate, and convert numbered references (e.g. [1]) into inline links using the URLs listed at the end of the message. For URLs that GitHub auto-links with nice formatting (e.g. issues, PRs, commits), use the bare URL. For other URLs, use a Markdown link with descriptive text. Remove the reference list at the end. After the transformed text, add a section headed '---' then 'Formatting notes:' briefly listing the decisions you made (e.g. which words you backticked, how you handled each reference)."
}
