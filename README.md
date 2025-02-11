# chwsl - WSL/Windows 環境を簡単に切り替えるシンプルなツール

`chwsl` は、Fish シェルで簡単に **Windows PowerShell** と **WSL 環境** を切り替えるためのスクリプトです。  
**インタラクティブな選択メニュー** 付きで、WSL のディストリビューションをすばやく選択できます。

## 📥 インストール方法

以下のコマンドを実行するだけでインストールできます：
```sh
curl -fsSL https://raw.githubusercontent.com/small-engineer/chwsl/main/install.sh | bash
```
🔹 **依存関係 (`fzf`, `fish`) が自動でインストールされます。**

---

## 🚀 使い方

```sh
chwsl             # Windows PowerShell に切り替え（デフォルト）
chwsl windows     # Windows PowerShell に切り替え
chwsl wsl         # WSL ディストリビューションをインタラクティブに選択
chwsl wsl Ubuntu-22.04  # 直接 Ubuntu-22.04 に切り替え
chwsl help        # ヘルプを表示
```

🔹 `chwsl wsl` を実行すると、**矢印キー（↑ / ↓）で選択、Enter で決定** できます。

---

## 🔄 アンインストール

`chwsl` を削除するには：
```sh
rm -f /srv/chwsl.fish
sed -i '/source \/srv\/chwsl.fish/d' ~/.config/fish/config.fish
```

---

## 📌 依存関係
- **WSL (`wsl.exe`)**: Windows Subsystem for Linux が必要です。
- **fzf**: インタラクティブな選択を可能にします。（自動インストール）
- **fish**: Fish シェルを使用。（自動インストール）

**💡 インストールスクリプトが依存関係を自動でチェックし、必要ならインストールします！**

---

# chwsl - A Simple Tool to Switch Between WSL and Windows

`chwsl` is a Fish shell function that allows you to quickly switch between **Windows PowerShell** and **WSL environments**.  
With an **interactive selection menu**, you can easily choose a WSL distribution.

## 📥 Installation

Run the following command to install:
```sh
curl -fsSL https://raw.githubusercontent.com/small-engineer/chwsl/main/install.sh | bash
```
🔹 **Dependencies (`fzf`, `fish`) will be installed automatically.**

---

## 🚀 Usage

```sh
chwsl             # Switch to Windows PowerShell (default)
chwsl windows     # Switch to Windows PowerShell
chwsl wsl         # Select a WSL distribution interactively
chwsl wsl Ubuntu-22.04  # Switch directly to Ubuntu-22.04
chwsl help        # Show help
```

🔹 Running `chwsl wsl` will display an **interactive menu** where you can use **arrow keys (↑ / ↓) to navigate and Enter to select**.

---

## 🔄 Uninstallation

To remove `chwsl`:
```sh
rm -f /srv/chwsl.fish
sed -i '/source \/srv\/chwsl.fish/d' ~/.config/fish/config.fish
```

---

## 📌 Dependencies
- **WSL (`wsl.exe`)**: Windows Subsystem for Linux is required.
- **fzf**: Enables interactive selection. (Automatically installed)
- **fish**: Uses the Fish shell. (Automatically installed)

**💡 The install script will automatically check for dependencies and install them if needed!**

---

🚀 **Easily switch between WSL and Windows with `chwsl`!** 🚀

