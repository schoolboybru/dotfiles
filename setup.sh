#!/bin/bash

set -e  # Exit on error

echo "Setting up your Mac..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install everything from Brewfile
echo "Installing Homebrew packages..."
brew bundle install

# Get the directory where this script lives
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink dotfiles in home directory
echo "Symlinking dotfiles..."

# Add your root-level dotfiles here
files=(".zshrc" ".tmux.conf" ".gitconfig")

for file in "${files[@]}"; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        ln -sfn "$DOTFILES_DIR/$file" "$HOME/$file"
        echo "  ✓ Linked $file"
    fi
done

# Symlink .config directory
echo "Symlinking .config directories..."
mkdir -p "$HOME/.config"

# Symlink .config subdirectories
for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        config_name=$(basename "$config_dir")
        ln -sfn "$config_dir" "$HOME/.config/$config_name"
        echo "  ✓ Linked .config/$config_name"
    fi
done

# Symlink individual .config files (e.g., opencode.json)
for config_file in "$DOTFILES_DIR/.config"/*; do
    if [ -f "$config_file" ]; then
        config_name=$(basename "$config_file")
        # Handle files that need to go into their own subdirectory
        if [ "$config_name" = "opencode.json" ]; then
            mkdir -p "$HOME/.config/opencode"
            ln -sfn "$config_file" "$HOME/.config/opencode/$config_name"
            echo "  ✓ Linked .config/opencode/$config_name"
        else
            ln -sfn "$config_file" "$HOME/.config/$config_name"
            echo "  ✓ Linked .config/$config_name"
        fi
    fi
done

echo ""
echo "✓ Setup complete!"
echo "You may need to restart your shell or source your config files."
