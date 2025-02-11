#!/bin/bash

function chwsl() {
    echo "DEBUG: chwsl start"

    if [ "$#" -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "?" ]; then
        cat <<EOF
Usage: chwsl [windows|wsl <distro>]

  windows       Switch to Windows PowerShell (default)
  wsl           List available WSL distributions and select one
  wsl <distro>  Switch to specified WSL distribution

Examples:
  chwsl             # Switch to Windows PowerShell
  chwsl windows     # Switch to Windows PowerShell
  chwsl wsl         # Select a WSL distribution by number
  chwsl wsl Ubuntu-22.04  # Switch to Ubuntu-22.04
EOF
        return 0
    fi

    echo "DEBUG: Argument: $1"

    case "$1" in
        windows)
            echo "Switching to Windows PowerShell..."
            exec cmd.exe /c "cd %USERPROFILE% && powershell.exe"
            ;;
        wsl)
            echo "DEBUG: Entering WSL case"
            if [ "$#" -lt 2 ]; then
                echo "Available WSL distributions:"
                distros_raw=$(wsl.exe -l --quiet | iconv -f utf-16le -t utf-8)
                distros_raw=$(echo "$distros_raw" | tr -d '\r')
                IFS=$'\n' read -r -d '' -a distros <<< "$distros_raw"$'\0'

                echo "DEBUG: Raw WSL output: ${distros[*]}"

                numbered_distros=()
                i=1
                for distro in "${distros[@]}"; do
                    if [ -n "$distro" ]; then
                        echo "$i) $distro"
                        numbered_distros+=("$distro")
                        i=$((i+1))
                    fi
                done

                echo -n "Select a WSL distribution (Enter number): "
                read selection

                if ! [[ "$selection" =~ ^[0-9]+$ ]]; then
                    echo "[error] Invalid input. Please enter a number."
                    return 1
                fi

                if [ "$selection" -lt 1 ] || [ "$selection" -gt "${#numbered_distros[@]}" ]; then
                    echo "[error] Invalid selection. Please enter a valid number."
                    return 1
                fi

                distro="${numbered_distros[$((selection-1))]}"
                echo "DEBUG: Selected distro: '$distro'"

                echo "Switching to WSL: $distro..."
                exec wsl.exe -d "$distro"
            else
                distro=$(echo "$2" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                echo "DEBUG: Manually specified distro: '$distro'"
                exec wsl.exe -d "$distro"
            fi
            ;;
        *)
            echo "[error] Invalid option: '$1'"
            return 1
            ;;
    esac

    echo "DEBUG: chwsl end"
}

chwsl "$@"

