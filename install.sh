#!/bin/bash

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Backup existing files
backup_file() {
    local file=$1
    if [ -f "$file" ] || [ -d "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_message "$YELLOW" "Creating backup of $file to $backup"
        cp -r "$file" "$backup"
    fi
}

# Create directory if it doesn't exist
ensure_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        print_message "$YELLOW" "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Main installation
print_message "$GREEN" "Starting installation of development environment..."

# Ensure ~/.config exists
ensure_directory "$HOME/.config"

# Install Neovim configuration
if [ -d "nvim" ]; then
    print_message "$GREEN" "Installing Neovim configuration..."
    backup_file "$HOME/.config/nvim"
    cp -r nvim "$HOME/.config/"
    print_message "$GREEN" "✓ Neovim configuration installed"
else
    print_message "$RED" "× Neovim directory not found"
fi

# Install Tmux configuration
if [ -d "tmux" ]; then
    print_message "$GREEN" "Installing Tmux configuration..."
    backup_file "$HOME/.config/tmux"
    cp -r tmux "$HOME/.config/"
    print_message "$GREEN" "✓ Tmux configuration installed"
else
    print_message "$RED" "× Tmux directory not found"
fi

# Handle bash configuration files
if [ -d "dotfiles" ]; then
    print_message "$GREEN" "Installing bash configurations..."
    
    # Backup existing bash files
    backup_file "$HOME/.bashrc"
    
    # Append bash configurations if they exist
    if [ -f "dotfiles/.bashrc" ]; then
        print_message "$GREEN" "Appending .bashrc configurations..."
        echo "" >> "$HOME/.bashrc"
        echo "# Added by dev-env installation script" >> "$HOME/.bashrc"
        cat "dotfiles/.bashrc" >> "$HOME/.bashrc"
    fi
    
    if [ -f "dotfiles/.bash_aliases" ]; then
        print_message "$GREEN" "Appending .bash_aliases configurations..."
        echo "" >> "$HOME/.bashrc"
        echo "# Added by dev-env installation script - aliases" >> "$HOME/.bashrc"
        cat "dotfiles/.bash_aliases" >> "$HOME/.bashrc"
    fi
    
    print_message "$GREEN" "✓ Bash configurations installed"
else
    print_message "$RED" "× Dotfiles directory not found"
fi

print_message "$GREEN" "Installation complete!"
print_message "$YELLOW" "Note: Please restart your terminal or run 'source ~/.bashrc' to apply bash changes."
