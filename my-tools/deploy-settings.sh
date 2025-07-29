#!/bin/bash
# ターゲットディレクトリに設定ファイルをシンボリックリンクで展開するスクリプト
# Usage: ./deploy-settings.sh TARGET_DIR

TARGET_DIR="${1:-$HOME}"


# 技術的に必須の除外（変更しない）
SYSTEM_EXCLUDE=("." ".." ".git")

# ユーザー設定の除外（プロジェクトに応じて変更する）
USER_EXCLUDE=("my-tools" "README.md" "LICENSE" ".gitignore" "docs")

# スクリプトが置かれているディレクトリ（my-tools）の親ディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_REPO="$(dirname "$SCRIPT_DIR")"

# 除外アイテムかどうかをチェックする関数
is_excluded() {
    local item="$1"
    for exclude in "${SYSTEM_EXCLUDE[@]}" "${USER_EXCLUDE[@]}"; do
        if [ "$item" = "$exclude" ]; then
            return 0
        fi
    done
    return 1
}

# ターゲットディレクトリに移動
cd "$TARGET_DIR"

# .git/info/exclude ファイルの準備
EXCLUDE_FILE="$TARGET_DIR/.git/info/exclude"

# settings repoの内容をシンボリックリンクで展開
for item in "$SETTINGS_REPO"/{.*,*}; do
    if [ -e "$item" ]; then
        basename_item="$(basename "$item")"
        
        # 除外アイテムをスキップ
        if is_excluded "$basename_item"; then
            continue
        fi
        
        # 既存のリンクまたはファイルがある場合は削除
        if [ -L "$basename_item" ] || [ -e "$basename_item" ]; then
            rm -rf "$basename_item"
        fi
        
        # シンボリックリンクを作成
        ln -s "$item" "$basename_item"
        
        # .git/info/exclude に追加
        echo "$basename_item" >> "$EXCLUDE_FILE"
    fi
done

# .git/info/exclude の重複を削除
if [ -f "$EXCLUDE_FILE" ]; then
    sort "$EXCLUDE_FILE" | uniq > "$EXCLUDE_FILE.tmp" && mv "$EXCLUDE_FILE.tmp" "$EXCLUDE_FILE"
fi
