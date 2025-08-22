#!/bin/bash

# 2 つの diff ファイルを作成するスクリプト
# - pr.diff : PR における差分
# - unpushed.diff : push されていない commit による差分 (PR あるいは base-branch との差分)

BRANCH=$(git branch --show-current)
mkdir -p "$BRANCH"

# pr.diff を作成 (PR が存在する場合のみ)
if gh pr view >/dev/null 2>&1; then
  gh pr diff > "$BRANCH/pr.diff"
  echo "Created pr.diff"
else
  echo "No PR found for current branch"
fi

# unpushed.diff を作成
if git rev-parse --abbrev-ref @{u} >/dev/null 2>&1; then
  # push 済みブランチの (upstream が設定されている) 場合、upstream との差分を出力
  git diff @{u}..HEAD > "$BRANCH/unpushed.diff"
  echo "Created unpushed.diff using @{u}"
else
  # 未 push ブランチの (upstream が設定されていない) 場合、そのブランチの commits による差分を出力
  # git diff $BASE..HEAD > "$BRANCH/unpushed.diff"
  # echo "Created unpushed.diff of $BASE"
fi
