#!/bin/bash

INSTALL_DIR="/srv"
FISH_CONFIG="$HOME/.config/fish/config.fish"
REPO_URL="https://raw.githubusercontent.com/small-engineer/chwsl/main/chwsl.fish"

echo "[info] Installing chwsl..."

if ! command -v sudo &> /dev/null; then
    echo "[error] sudo is not installed. Please install sudo first."
    exit 1
fi

if [ ! -d "$INSTALL_DIR" ]; then
    echo "[info] Creating /srv directory (requires sudo)"
    sudo mkdir -p "$INSTALL_DIR"
fi

# 依存関係の確認とインストール
if ! command -v fzf &> /dev/null; then
    echo "[info] Installing fzf (requires sudo)"
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
    echo "[info] Installing fish shell (requires sudo)"
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

echo "[info] Downloading chwsl.fish (requires sudo)"
sudo curl -fsSL "$REPO_URL" -o "$INSTALL_DIR/chwsl.fish"

sudo chmod +x "$INSTALL_DIR/chwsl.fish"

if ! grep -q "source $INSTALL_DIR/chwsl.fish" "$FISH_CONFIG"; then
    echo "source $INSTALL_DIR/chwsl.fish" | sudo tee -a "$FISH_CONFIG"
    echo "[info] Added chwsl to fish config"
fi

source "$FISH_CONFIG"

echo "[success] Installation complete! Use 'chwsl' to switch environments."
exit 0

