#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Sonokai-themed FZF Prompt
export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,bg:-1,spinner:#76CCE0,hl:#FC5D7C,gutter:-1 \
--color=fg:#595F6F,header:#FC5D7C,info:#595F6F,pointer:#76CCE0,border:#595F6F \
--color=marker:#B39DF3,fg+:#9CABCA,prompt:#595F6F,hl+:#76CCE0"

# PS1 configs (configure according to your terminal colorscheme):

# This one shows the whole path
PS1='\n\e[1;30m\w\e[1m\n\e[1;35m~❯\e[0m '

# This one shows only the current working directory
# PS1='\n\e[1;30m\W\e[1m\n\e[1;35m~❯\e[0m '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
