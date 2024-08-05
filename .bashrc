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
HISTSIZE=4000
HISTFILESIZE=9000

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
#alias cn='ssh -X nates_science@10.20.5.74'
alias cn='ssh -X nates_science@10.20.1.89'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias f='xdg-open .'
alias n='nvim'
alias o='xdg-open'
alias d="find * -type f -cmin -3 exec mv '{}' tmp \;"
alias sb='. ~/.bashrc'
alias eb='n ~/.bashrc'
alias pyt='python'
alias pyth='python'
alias mp='multipass'
alias rmm='rm ~/.config/monitors.xml~'

alias pyt='python3'
alias pythom='python3'
alias pythomo='python3'
alias pythono='python3'
alias pyhton='python3'
alias pyhtono='python3'
alias pyton='python3'

alias m='make'
alias vs='vsim -view vsim.wlf -do wave.do'

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

. /usr/share/autojump/autojump.sh


#PATH=$PATH:~/Downloads/oss-cad-suite/bin
#PATH=$PATH:~/Downloads/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin
#PATH=$PATH:~/Downloads/wishbone
#PATH=$PATH:~/lscc/radiant/3.2/bin/lin64/
#PATH=$PATH:~/lscc/radiant/3.2/programmer/bin/lin64
#PATH=$PATH:~/lscc/radiant/3.2/modeltech/linuxloem/
#. "$HOME/.cargo/env"

#export bindir="/home/nates/lscc/radiant/3.2/bin/lin64"
#source $bindir/radiant_env

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/pym32/lib
#export PATH=/opt/pym32/lib:$PATH
#export PATH=/opt/pym32/bin:$PATH
#export PATH=/home/nates/.local/lib/python3.8/site-packages:$PATH
export PATH=/home/nates/.local/lib/python3.10/site-packages:$PATH
#export PATH="$HOME/.local/lib/python3.10/site-packages/amaranth"


shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export PICO_SDK_PATH=/home/nates/pico/pico-sdk
export PICO_EXAMPLES_PATH=/home/nates/pico/pico-examples
export PICO_EXTRAS_PATH=/home/nates/pico/pico-extras
export PICO_PLAYGROUND_PATH=/home/nates/pico/pico-playground
export PICO_SDK_PATH=/home/nates/rpi/pico/pico-sdk
export PICO_EXAMPLES_PATH=/home/nates/rpi/pico/pico-examples
export PICO_EXTRAS_PATH=/home/nates/rpi/pico/pico-extras
export PICO_PLAYGROUND_PATH=/home/nates/rpi/pico/pico-playground
export PICO_SDK_PATH=/home/nates/rpi/pico/pico-sdk
export PICO_EXAMPLES_PATH=/home/nates/rpi/pico/pico-examples
export PICO_EXTRAS_PATH=/home/nates/rpi/pico/pico-extras
export PICO_PLAYGROUND_PATH=/home/nates/rpi/pico/pico-playground

export PATH="$PATH:$HOME/oss-cad-suite/bin"

export XAUTHORITY=~/.Xauthority

#eval "$(direnv hook bash)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$PATH:/usr/local/go/bin

