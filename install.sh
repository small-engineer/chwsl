#!/bin/bash

INSTALL_DIR="/srv"
FISH_CONFIG="$HOME/.config/fish/config.fish"
REPO_URL="https://github.com/small-engineer/chwsl/main/chwsl.fish"

echo "[info] Installing chwsl..."

if ! command -v wsl.exe &> /dev/null; then
    echo "[error] WSL is not installed. Please install WSL first."
    exit 1
fi

if ! command -v fzf &> /dev/null; then
    echo "[info] Installing fzf..."
    if [ -x "$(command -v apt)" ]; then
        sudo apt update && sudo apt install -y fzf
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -S --noconfirm fzf
    elif [ -x "$(command -v brew)" ]; then
        brew install fzf
    else
        echo "[error] Package manager not found. Install fzf manually."
        exit 1
    fi
fi

if ! command -v fish &> /dev/null; then
    echo "[info] Installing fish shell..."
    if [ -x "$(command -v apt)" ]; then
        sudo apt update && sudo apt install -y fish
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -S --noconfirm fish
    elif [ -x "$(command -v brew)" ]; then
        brew install fish
    else
        echo "[error] Package manager not found. Install fish manually."
        exit 1
    fi
fi

curl -fsSL "$REPO_URL" -o "$INSTALL_DIR/chwsl.fish"
chmod +x "$INSTALL_DIR/chwsl.fish"

if ! grep -q "source $INSTALL_DIR/chwsl.fish" "$FISH_CONFIG"; then
    echo "source $INSTALL_DIR/chwsl.fish" >> "$FISH_CONFIG"
    echo

