#!/bin/bash
# 指定したファイルに対して、PR 単位で同時に変更されたファイルを集計する
# どのブランチで実行しても、origin/develop ブランチの最新状態を参照する

target_file="$1"
if [[ -z "$target_file" ]]; then
    echo "Usage: $0 <target-file>"
    exit 1
fi

# 最新のリモート情報を取得
git fetch

# target-file を変更した全コミットを取得
git log --follow --oneline -- "$target_file" origin/develop | while read hash _; do
    # そのコミットを最初に取り込んだマージコミット（PR）を特定
    merge_commit=$(git log --merges --oneline --ancestry-path ${hash}..origin/develop | tail -1)
    
    if [[ -n "$merge_commit" ]]; then
        merge_hash=$(echo "$merge_commit" | cut -d' ' -f1)
        # そのPRで変更された全ファイルを取得
        git diff --name-only ${merge_hash}^1 ${merge_hash}
    fi
# 出力から target_file を除外し、ファイルごとの変更回数をカウント
done | grep -v "$target_file" | sort | uniq -c | sort -nr

# 出力イメージ:
#      8 src/auth/login.test.js
#      5 src/utils/validator.js  
#      3 docs/api.md
#      2 package.json
#      1 src/config/auth.js
# 
# 数字は「target-fileと同じPRで変更された回数」を表す
