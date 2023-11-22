# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set Vim as Default Editor
export VISUAL=vim.gtk3
export EDITOR=$VISUAL

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin

alias python=python3
alias updg="sudo apt update && sudo apt upgrade -y && sudo flatpak update -y && sudo snap refresh --list && npm update -g && brew update && brew upgrade && sudo apt autoremove -y"

# Vim
alias vim=vim.gtk3

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Oh My Posh
eval "$(oh-my-posh --init --shell bash --config $(brew --prefix oh-my-posh)/themes/blueish.omp.json)"

# Salesforce stuff
sf-apex-run-test() {
  sf apex run --target-org "$1" --file "$2"
}

sf-apex-log() {
  sf apex get log --log-id "$1" --target-org "$2"
}

sf-apex-last-logs() {
  sf apex get log --number "$1"
}

sf-apex-download-log() {
  sf apex get log --output-dir "$1" --number "$2"
}

sf-apex-get-test-result() {
  sf apex get test --test-run-id "$1"
}

sf-apex-get-test-result-junit() {
  sf apex get test --test-run-id "$1" --result-format junit
}

sf-apex-get-test-result-coverage() {
  sf apex get test --test-run-id "$1" --code-coverage --json
}

sf-apex-download-test() {
  sf apex get test --test-run-id "$1" --code-coverage --output-dir "$2" --target-org "$3"
}

alias sf-apex-tail-log="sf apex tail log"
alias sf-apex-list-log="sf apex list log"

sf-apex-create-class() {
  local destination_dir=$(2:force-app/main/default/classes)

  sf apex generate class --name "$1" --template=DefaultApexClass --output-dir $destination_dir
}

sf-apex-create-test() {
  local destination_dir=$(2:force-app/main/default/classes)

  sf apex generate class --name "$1" --template=ApexUnitTest --output-dir $destination_dir
}

sf-apex-create-exception() {
  local destination_dir=$(2:force-app/main/default/classes)

  sf apex generate class --name "$1" --template=ApexException --output-dir $destination_dir
}

sf-apex-create-inbound-email-service() {
  local destination_dir=$(2:force-app/main/default/classes)

  sf apex generate class --name "$1" --template=InboundEmailService --output-dir $destination_dir
}

sf-apex-create-trigger() {
  local destination_dir=$(2:force-app/main/default/triggers)

  sf apex generate trigger --name "$1" --output-dir $destination_dir
}

sf-apex-create-trigger-with-events() {
  # events e.g.: "before insert, after insert"
  local destination_dir=$(2:force-app/main/default/triggers)

  sf apex generate trigger --name "$1" --output-dir $destination_dir --event "$3"
}

sf-package() {
  local destination_dir=$(3:manifest/)

  sf sgd source delta -f "$1" -t "$2" -o $destination_dir
}

sf-query-get() {
  sf data get record --sobject "$1" --where "$2"
}

sf-query-create() {
  sf data create record --sobject "$1" --values "$2"
}

sf-query-delete() {
  sf data delete record --sobject "$1" --where "$2"
}

sf-export-data() {
  sf data export tree --query "$1" --output-dir "$2" --target-org "$3"
}

sf-import-data() {
  sf data import tree --files "$1" --target-org "$2"
}

sf-query-soql() {
  sf data query --query "$1" --target-org "$2"
}

sf-deploy-preview() {
  sf project deploy preview --metadata "$1" --target-org "$2"
}

alias sfcd="sf deploy metadata cancel"

sf-deploy() {
  sf project deploy start --metadata "$1" --target-org "$2"
}

sf-retrieve-preview() {
  sf project retrieve preview -o "$1" --target-org "$2"
}

sf-retrieve() {
  sf project retrieve start --metadata "$1" --target-org "$2"
}

sf-object-describe() {
  sf sobject describe --sobject "$1" --target-org "$2"
}
