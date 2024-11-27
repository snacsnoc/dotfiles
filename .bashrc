# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

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

#PS1="\[\e[00;37m\][\[\e[0m\]\[\e[00;32m\]\u\[\e[0m\]\[\e[00;33m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]]\[\e[0m\]\[\e[00;36m\][\w]\[\e[0m\]\$ "
PS1="\[\e[00;37m\][\[\e[0m\]\[\e[00;32m\]\u\[\e[0m\]\[\e[00;33m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]]\[\e[0m\]\[\e[00;36m\][\w]\[\e[0m\]\[\$(git branch 2>/dev/null | grep '^*' | colrm 1 2 | awk '{print \" (\" \$1 \")\"}')\]\$ "
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Function to paste content to https://paste.rs and copy URL to clipboard
function paste() {
    if [[ -p /dev/stdin ]]; then
        # Read from stdin if input is piped
        local url=$(curl -s --data-binary @- https://paste.rs)
    else
        # Read from file if an argument is provided
        local file="${1:-/dev/stdin}"
        local url=$(curl -s --data-binary @"${file}" https://paste.rs)
    fi

    if [[ "$(uname)" == "Darwin" ]]; then
        echo "$url" | pbcopy  # Copy to clipboard on macOS
        echo "Paste URL copied to clipboard: $url"
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "$url" | xclip -selection clipboard  # Copy to clipboard on Linux
        echo "Paste URL copied to clipboard: $url"
    else
        echo "Paste URL: $url"
    fi
}


mkcd(){
 mkdir $1 && cd $1
}

#Homebrew for x86_64
function ibrew() {
   arch --x86_64 /usr/local/bin/brew $@
}


alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias au='sudo apt update'
alias ag='sudo apt upgrade'
alias ai='sudo apt install'
alias ccat='pygmentize -g'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ~="cd ~" 

# Git stuff
alias gs='git status'
alias gd='git diff'
alias gb='git branch'

# Python stuff
alias cvenv='python3 -m venv'
alias actenv='source venv/bin/activate'
alias serve='python3 -m http.server 8000'

# Mac aliases 

# brew install jwbargsten/misc/defbro
# https://github.com/jwbargsten/defbro
alias set-ff='defbro org.mozilla.firefox'
alias set-cr='defbro com.google.Chrome'
alias set-sf='defbro com.apple.SafariTechnologyPreview'

alias brewup='brew update && brew upgrade && brew cleanup' # Update and upgrade Homebrew
alias myip='curl ifconfig.me'            
alias localip='ipconfig getifaddr en0'    
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder' 


alias spotify='open -a Spotify'        


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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -n "$ZSH_VERSION" ]; then
    if command -v ngrok &>/dev/null; then
      eval "$(ngrok completion)"
    fi
fi


# Check the operating system
if [[ "$(uname)" == "Darwin" ]]; then
    # MacOS specific PATH
    export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/opt/libpq/bin:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:/Users/easto/.cargo/bin:/usr/local/bin:/Users/easto/Downloads/google-cloud-sdk/bin:$PATH"
else
    # Linux specific PATH
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$PATH"
fi


