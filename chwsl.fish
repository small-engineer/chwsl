#!/usr/bin/fish

function chwsl
    #---------------------------
    # 1) 引数から debug を取り除く
    #---------------------------
    set debug_mode 0
    set filteredArgs

    for arg in $argv
        if test "$arg" = "debug"
            set debug_mode 1
        else
            set filteredArgs $filteredArgs $arg
        end
    end

    #---------------------------
    # 2) debug_mode が有効ならメッセージ
    #---------------------------
    if test "$debug_mode" -eq 1
        echo "DEBUG: debug mode enabled"
    end

    #---------------------------
    # 3) ヘルプ表示
    #---------------------------
    if test (count $filteredArgs) -eq 0 -o "$filteredArgs[1]" = "help" -o "$filteredArgs[1]" = "?"
        echo "Usage: chwsl [windows|wsl <distro>] [debug]"
        echo ""
        echo "  windows       Switch to Windows PowerShell (default)"
        echo "  wsl           List available WSL distributions and select one"
        echo "  wsl <distro>  Switch to specified WSL distribution"
        echo ""
        echo "Options:"
        echo "  debug         Enable debug mode (verbose logging)"
        echo ""
        echo "Examples:"
        echo "  chwsl windows            # Switch to Windows PowerShell"
        echo "  chwsl wsl                # Select a WSL distribution by fzf or number"
        echo "  chwsl wsl Ubuntu-22.04   # Switch to Ubuntu-22.04"
        echo "  chwsl wsl debug          # Enable debug mode + WSL selection"
        return 0
    end

    #---------------------------
    # 4) メイン処理
    #---------------------------
    switch $filteredArgs[1]
        case "windows"
            echo "Switching to Windows PowerShell..."
            exec cmd.exe /c "cd %USERPROFILE% && powershell.exe"

        case "wsl"
            if test "$debug_mode" -eq 1
                echo "DEBUG: Entering WSL case"
            end

            # 第2引数がなければ、ディストロ名未指定
            if test (count $filteredArgs) -lt 2
                #---- 4.1) ディストリビューション一覧取得
                set distros (wsl.exe -l --quiet | iconv -f utf-16le -t utf-8 | string trim | string split "\n")

                if test "$debug_mode" -eq 1
                    echo "DEBUG: Raw WSL output: $distros"
                end

                #---- 4.2) fzf が使えるかチェック
                if command -q fzf
                    #===========
                    # fzf 選択
                    #===========
                    if test "$debug_mode" -eq 1
                        echo "DEBUG: fzf is available. Using fzf for selection."
                    end

                    # リストが空でなければ "Cancel" 選択を追加
                    set selectionCandidates "Cancel"
                    for d in $distros
                        if test -n "$d"
                            set selectionCandidates $selectionCandidates $d
                        end
                    end

                    # fzf 実行
                    set distro (printf "%s\n" $selectionCandidates | fzf --prompt=" Select WSL distro: " \
                                                                     --height=10 \
                                                                     --reverse \
                                                                     --border=rounded \
                                                                     --border-label=" WSL Selection " \
                                                                     --border-label-pos=3)

                    # fzf キャンセル or Cancel の場合
                    if test -z "$distro" -o "$distro" = "Cancel"
                        echo "[info] Operation canceled"
                        return 1
                    end

                    if test "$debug_mode" -eq 1
                        echo "DEBUG: fzf selected distro: '$distro'"
                    end

                    echo "Switching to WSL: $distro..."
                    command wsl.exe -d "$distro"

                else
                    #=============================
                    # fzf がない → 番号選択にフォールバック
                    #=============================
                    echo "Available WSL distributions:"

                    set numbered_distros
                    set i 1
                    for distro in $distros
                        if test -n "$distro"
                            echo "$i) $distro"
                            set numbered_distros $numbered_distros $distro
                            set i (math $i + 1)
                        end
                    end

                    echo -n "Select a WSL distribution (Enter number): "
                    read selection

                    if not string match -rq '^[0-9]+$' -- $selection
                        echo "[error] Invalid input. Please enter a number."
                        return 1
                    end

                    if test $selection -lt 1 -o $selection -gt (count $numbered_distros)
                        echo "[error] Invalid selection. Please enter a valid number."
                        return 1
                    end

                    set distro $numbered_distros[$selection]
                    if test "$debug_mode" -eq 1
                        echo "DEBUG: Selected distro: '$distro'"
                    end

                    echo "Switching to WSL: $distro..."
                    command wsl.exe -d "$distro"
                end

            else
                #---- 4.3) ディストロ名が指定されている場合
                set distro (string trim "$filteredArgs[2]")
                if test "$debug_mode" -eq 1
                    echo "DEBUG: Manually specified distro: '$distro'"
                end
                command wsl.exe -d "$distro"
            end

        case "*"
            echo "[error] Invalid option: '$filteredArgs[1]'"
            return 1
    end

    if test "$debug_mode" -eq 1
        echo "DEBUG: chwsl end"
    end
end
