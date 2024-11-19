alias cls=clear
alias vim=nvim # Best alias ever
alias fetch=fastfetch

alias tls='tmux ls'

# Create new Tmux sessions with "tn [word]" notation
tn() {
  local session_name="${1#tn }"
  echo "Creating new session: '$session_name'"
  tmux new-session -s "$session_name"
}

# Attach to an existing Tmux session with "ta [word]" notation
ta() {
  local session_name="${1#ta }"
  echo "Attaching to session: '$session_name'"
  tmux attach-session -t "$session_name"
}

# Kill an existing Tmux session with "tk [word]" notation
tk() {
  local session_name="${1#tk }"
  echo "Killing session: '$session_name'"
  tmux kill-session -t "$session_name"
}

# Git aliases
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'

# Fuzzy find
alias ff='fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim'

# Directory fuzzy find
alias dff='cd $(fd --type directory --hidden | fzf-tmux -p)'
