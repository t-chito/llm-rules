#!/bin/bash

# Usage: ./list-diffs.sh <ファイル名>
# 指定されたファイルの git ログと diff を抽出してファイルに出力する

filename="$1"
output_file="${filename//\//_}.diff" # / を _ に置換

# ファイルを変更したコミットを取得（新しい順）
commits=$(git log --format="%H" --follow -- "$filename")

{
    first=true
    for commit in $commits; do
        if [ "$first" = false ]; then
            echo ""
            echo "==============================================="
            echo ""
        fi
        first=false
        
        # このコミットでの特定ファイルのdiffを取得
        git show "$commit" -- "$filename"
    done
} > "$output_file"

echo "出力ファイル: $output_file"
