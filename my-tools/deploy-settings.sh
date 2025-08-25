#!/bin/bash
# 設定ファイルをシンボリックリンクで展開するスクリプト
# Usage: (展開したい prj 以下で) ./deploy-settings.sh



# プロジェクトルートに ln するもの
PRJ_ROOT_LN=(".textlintrc" ".vscode" )

# $HOME に ln するもの
HOME_LN=(".bashrc" ".claude" ".github" ".mcp.json"  ".zshrc" "my-tools")

# スクリプトが置かれているディレクトリ（my-tools）の親ディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_REPO="$(dirname "$SCRIPT_DIR")"

# .git ディレクトリが存在するなら .git/info/exclude ファイルを準備
EXCLUDE_FILE=""
if [ -d "./.git" ]; then
    EXCLUDE_FILE="$TARGET_DIR/.git/info/exclude"
fi

# プロジェクトでPRJ_ROOT_LNを展開
for item in "${PRJ_ROOT_LN[@]}"; do
    item_path="$SETTINGS_REPO/$item"
    if [ -e "$item_path" ]; then
        # 既存のリンクまたはファイルがある場合は削除
        if [ -L "$item" ] || [ -e "$item" ]; then
            rm -rf "$item"
        fi
        
        # シンボリックリンクを作成
        ln -s "$item_path" "$item"
    fi
done

# .git/info/exclude の重複を削除 (if it exists)
if [ -n "$EXCLUDE_FILE" ] && [ -f "$EXCLUDE_FILE" ]; then
    sort "$EXCLUDE_FILE" | uniq > "$EXCLUDE_FILE.tmp" && mv "$EXCLUDE_FILE.tmp" "$EXCLUDE_FILE"
fi

# $HOME ディレクトリで HOME_LN を展開
cd "$HOME"

for item in "${HOME_LN[@]}"; do
    item_path="$SETTINGS_REPO/$item"
    if [ -e "$item_path" ]; then
        # 既存のリンクまたはファイルがある場合は削除
        if [ -L "$item" ] || [ -e "$item" ]; then
            rm -rf "$item"
        fi
        
        # シンボリックリンクを作成
        ln -s "$item_path" "$item"
    fi
done
