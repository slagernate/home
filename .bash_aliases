
alias scifi2='10.40.62.166'
# some more ls aliases
#alias cn='ssh -X nates_science@10.20.5.74'
alias cn='ssh -X nates_science@10.20.1.89'
alias ls='ls -alF --color=auto'
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

# batcat (pretty cat):
alias bc='batcat --pager="less -RFX"'

# git aliases
alias gau='git add -u'
alias gcm='git commit -m'
alias gs='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gl='git log -7'
alias gla='git log --oneline --decorate --graph --all'
alias gc='git checkout'
alias gd='git diff'
alias gss='git stash show -p stash@{0}'

# function to execute git stash show -p stash@{n}:
function gssn() {
    if [ -z "$1" ]; then
        echo "Usage: gssn <stash_number>"
        return 1
    fi
    git stash show -p "stash@{$1}"
}
# example usage:
# gssn 1

alias m='make'
alias mb='make build'
alias mc='make clean'
alias vs='vsim -view vsim.wlf -do wave.do'

#alias nterm='nvim -c ":term"'
alias nterm='nvim -c ":term" -c "startinsert"'

# pdm python alias
alias pdmr='pdm run'

alias sdklu='/usr/bin/turbox-sdkmanager-setup.sh --os-version 20.04'

# ecpprog aliases
alias sram='ecpprog -k 4 -S'
alias flash='ecpprog -k 4'
alias now='touch now && ls -la now && rm now'
