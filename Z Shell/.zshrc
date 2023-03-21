HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats 'on %b'
setopt PROMPT_SUBST

# PROMPT='%F{%(#.blue.green)}(%B%F{%(#.red.blue)}%n%(#.💀.㉿)%m%b%F{%(#.blue.green)})-[%B%F{r>%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
# PROMPT='%n@%m %F{red}%/%f$ $ '
PROMPT='%F{yellow}%n@%m%f%F{green}${vcs_info_msg_0_}%f '

