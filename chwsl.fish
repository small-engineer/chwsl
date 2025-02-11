#!/usr/bin/fish

function chwsl
    # Show help
    if test (count $argv) -eq 0 -o "$argv[1]" = "help" -o "$argv[1]" = "?"
        echo "Usage: chwsl [windows|wsl <distro>]"
        echo ""
        echo "  windows       Switch to Windows PowerShell (default)"
        echo "  wsl           List available WSL distributions (interactive)"
        echo "  wsl <distro>  Switch to specified WSL distribution"
        echo ""
        echo "Examples:"
        echo "  chwsl             # Switch to Windows PowerShell"
        echo "  chwsl windows     # Switch to Windows PowerShell"
        echo "  chwsl wsl         # List WSL distributions and select one"
        echo "  chwsl wsl Ubuntu-22.04  # Switch to Ubuntu-22.04"
        return 0
    end

    switch $argv[1]
        case "windows"
            echo "Switching to Windows PowerShell..."
            exec cmd.exe /c "cd %USERPROFILE% && powershell.exe"

        case "wsl"
            # If no distro specified, show interactive selection
            if test (count $argv) -lt 2
                set distro (begin
                    echo "Cancel"
                    wsl.exe -l --quiet | string trim
                end | fzf --prompt=" Select WSL distro: " \
                         --height=10 --reverse --border=rounded \
                         --border-label=" WSL Selection " \
                         --border-label-pos=3)

                if test -z "$distro" -o "$distro" = "Cancel"
                    echo "[info] Operation canceled"
                    return 1
                end
                echo "Switching to WSL: $distro..."
                exec wsl.exe -d "$distro"
            else
                echo "Switching to WSL: $argv[2]..."
                exec wsl.exe -d $argv[2]
            end

        case "*"
            echo "[error] Invalid option: '$argv[1]'"
            echo "Usage: chwsl [windows|wsl <distro>]"
            return 1
    end
end

