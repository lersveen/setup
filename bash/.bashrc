# Force UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Fancy colours in terminal
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add some extra functionality to ls by default
alias ls='ls -GFh'
alias programsjekk="cd ~/github/monitoring-programsjekk"
alias himin="cd ~/github/monitoring-himin"

# Set path
export PATH="~/bin:/usr/local/sbin:$PATH"

# Git branch in prompt
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Auto-complete for kubectl
source <(kubectl completion bash)

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Shortcut to start ssh tunnel
alias ssh-tunnel='ssh -N -v jump01'

# VSCode as default editor
export EDITOR="code -n -w"

# Nano as editor for crontab (etc?)
export VISUAL="nano"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/n06715/google-cloud-sdk/path.bash.inc' ]; then . '/Users/n06715/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/n06715/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/n06715/google-cloud-sdk/completion.bash.inc'; fi

