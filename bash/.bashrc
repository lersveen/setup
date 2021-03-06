# Force UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Fancy colours in terminal
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Add some extra functionality to ls by default
alias ls='ls -GFh'

# Shortcut to start ssh tunnel
alias ssh-tunnel='ssh -N -v jump01'

# Add ~/bin and /usr/local/sbin to path
export PATH="~/bin:/usr/local/sbin:$PATH"

# Add ruby and ruby gems to path
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:/usr/local/opt/ruby/bin:$PATH"

# Tell SSH how to access the gpg-agent and make sure gpg-agent is launched and ready for use.
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

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

# VSCode as default editor
export EDITOR="code -n -w"

# Nano as editor for crontab (etc?)
export VISUAL="nano"

# Update PATH for the Google Cloud SDK
if [ -f '/Users/n06715/google-cloud-sdk/path.bash.inc' ]; then . '/Users/n06715/google-cloud-sdk/path.bash.inc'; fi

# Enable shell command completion for gcloud
if [ -f '/Users/n06715/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/n06715/google-cloud-sdk/completion.bash.inc'; fi
