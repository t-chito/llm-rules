#!/bin/bash

# Usage: ./list-diffs.sh <ファイル名>
# 指定されたファイルの git ログと diff を抽出してファイルに出力する

filename="$1"
output_file="${filename//\//_}_diff.md" # / を _ に置換

# ファイルを変更したコミットを取得（新しい順）
commits=$(git log --format="%H" --follow -- "$filename")

{
    echo "# Git History for $filename"
    echo ""

    first=true
    for commit in $commits; do
        if [ "$first" = false ]; then
            echo ""
            echo "---"
            echo ""
        fi
        first=false
        
        # コミットメッセージを取得
        message=$(git log -1 --format="%s" "$commit")
        
        echo "commit $commit"
        echo "message $message"
        echo ""
        
        # このコミットでの特定ファイルのdiffを取得
        git show "$commit" -- "$filename"
    done
} > "$output_file"

echo "出力ファイル: $output_file"
