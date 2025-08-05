# This file is currently a work in progress. I have also started an alias file. I will probably seperate all of these files 
# in such a way to make them a bit more organized.


# Commented out as storing values in three seperate files turned out to be more cumbersome than it was worth
# source .alias
# source .functions
# source .profile

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset



alias ll="ls -l"
alias lo="ls -o"
alias lh="ls -lh"
alias la="ls -la"
alias sl="ls"
alias l="ls"
alias s="ls"

# Move 'up' so many directories instead of using several cd ../../, etc.
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

#Another variation of the one above
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
#Tail all logs in /var/log
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Colors for All grep commands such as grep, egrep and zgrep
export GREP_OPTIONS='--color=auto'

# Git related
alias gs='git status'
alias gc='git commit'
alias ga='git add .'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gsb='git show-branch'
alias gco='git checkout'
alias gg='git grep'
alias gk='gitk --all'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias gcp='git cherry-pick'
alias grm='git rm'

# For when you've spent too much time in DOS
alias cls="clear"
alias dir="ls"
alias deltree="rm -r"
alias rmdir="rm -r"
alias rd="rm -r"
alias rename="mv"
alias chdir="pwd"
alias cmd="bash"
alias edit="nano -m -u -c -W --tabsize=4 --fill=100 --autoindent"
alias erase="rm"
alias del="rm"
alias delete="rm"
alias expand="extract"
diskcopy(){ dd if=$1 of=$2; }
alias tasklist="htop"
alias tracert="traceroute"

# Alias for Months of the year
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'


function git_init() {
    if [ -z "$1" ]; then
        printf "%s\n" "Please provide a directory name.";
    else
        mkdir "$1";
        builtin cd "$1";
        pwd;
        git init;
        touch readme.md .gitignore LICENSE;
        echo "# $(basename $PWD)" >> readme.md
    fi
}

function weather_report() {

    local response=$(curl --silent 'https://api.openweathermap.org/data/2.5/weather?id=5128581&units=imperial&appid=<YOUR_API_KEY>') 

    local status=$(echo $response | jq -r '.cod')

	# Check for the 200 response indicating a successful API query.
    case $status in
		
        200) printf "Location: %s %s\n" "$(echo $response | jq '.name') $(echo $response | jq '.sys.country')"  
             printf "Forecast: %s\n" "$(echo $response | jq '.weather[].description')" 
             printf "Temperature: %.1f°F\n" "$(echo $response | jq '.main.temp')" 
             printf "Temp Min: %.1f°F\n" "$(echo $response | jq '.main.temp_min')" 
             printf "Temp Max: %.1f°F\n" "$(echo $response | jq '.main.temp_max')" 
            ;;
        401) echo "401 error"
            ;;
        *) echo "error"
            ;;

    esac

}

function hg() {
    history | grep "$1";
}

#Search for a specific file 
findfile() {
   file = "$@"
   file += "*"
   find . -iname $file 2>&1 | grep -v "Operation not permitted"
}

#Search for all files with a specific extension
findext() {
   ext = "*."
   ext += "$@"
   find . -iname $ext 2>&1 | grep -v "Operation not permitted"
}

export PS1="\u@\h\w\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\\$\[$(tput sgr0)\]"
