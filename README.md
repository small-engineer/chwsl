# chwsl - A Simple Tool to Switch Between WSL and Windows

`chwsl` is a Fish shell script that allows quick switching between **Windows PowerShell** and **WSL environments**.  
With an **interactive selection menu**, you can easily choose a WSL distribution.

## 📥 Installation

```sh
curl -fsSL https://raw.githubusercontent.com/small-engineer/chwsl/main/install.sh | bash
source ~/.config/fish/config.fish
```

🔹 `fzf` and `fish` will be installed automatically.

## 🚀 Usage

[![Use Image](https://github.com/small-engineer/chwsl/blob/main/images/image.png)](https://github.com/small-engineer/chwsl/blob/main/images/image.png)

```sh
chwsl             # Switch to Windows PowerShell (default)
chwsl windows     # Switch to Windows PowerShell
chwsl wsl         # Select a WSL distribution interactively
chwsl wsl Ubuntu-22.04  # Switch directly to Ubuntu-22.04
chwsl help        # Show help
```

🔹 Running `chwsl wsl` will display an **interactive menu** where you can **navigate with arrow keys (↑ / ↓) and select with Enter**.

## 🔄 Uninstallation

```sh
rm -f /srv/chwsl.fish
sed -i '/source \/srv\/chwsl.fish/d' ~/.config/fish/config.fish
```

## 📌 Requirements

- **WSL (`wsl.exe`)**
- **fzf** (installed automatically)
- **fish** (installed automatically)


---

# chwsl - WSL/Windows 環境を簡単に切り替えるシンプルなツール

`chwsl` は、Fish シェルで **Windows PowerShell** と **WSL 環境** を簡単に切り替えるためのスクリプトです。  
**インタラクティブな選択メニュー** を備え、WSL のディストリビューションを素早く選択できます。

## 📥 インストール

```sh
curl -fsSL https://raw.githubusercontent.com/small-engineer/chwsl/main/install.sh | bash
source ~/.config/fish/config.fish
```

🔹 `fzf` と `fish` は自動でインストールされます。

## 🚀 使い方

```sh
chwsl             # Windows PowerShell に切り替え（デフォルト）
chwsl windows     # Windows PowerShell に切り替え
chwsl wsl         # WSL ディストリビューションを選択
chwsl wsl Ubuntu-22.04  # 直接 Ubuntu-22.04 に切り替え
chwsl help        # ヘルプを表示
```

🔹 `chwsl wsl` では **矢印キー（↑ / ↓）で選択、Enter で決定** できます。

## 🔄 アンインストール

```sh
rm -f /srv/chwsl.fish
sed -i '/source \/srv\/chwsl.fish/d' ~/.config/fish/config.fish
```

## 📌 必要環境

- **WSL (`wsl.exe`)**
- **fzf**（自動インストール）
- **fish**（自動インストール）


