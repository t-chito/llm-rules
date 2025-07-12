#!/bin/bash

# .claude/workspaces/
# ├── add-fuga/
# │   └── base-branch    # "origin/base-hoge" と書かれている
# ├── feature-xyz/
# │   └── base-branch    # "develop" と書かれている
# └── ...
#
# 上記のディレクトリ構造を前提に、2 つの diff ファイルを作成するスクリプト
# - pr.diff : PR における差分
# - unpushed.diff : push されていない commit による差分 (PR か base-branch との差分)

BRANCH=$(git branch --show-current)
DIFF_DIR=".claude/workspaces/$BRANCH"

mkdir -p "$DIFF_DIR"

# base-branch ファイルがない場合、デフォルトでローカルの develop ブランチを使うようにする
if [ ! -f "$DIFF_DIR/base-branch" ]; then
   echo "develop" > "$DIFF_DIR/base-branch"
   echo "Created $DIFF_DIR/base-branch with default: develop"
fi

# pr.diff を作成 (PR が存在する場合のみ)
if gh pr view >/dev/null 2>&1; then
  gh pr diff > "$DIFF_DIR/pr.diff"
  echo "Created pr.diff"
else
  echo "No PR found for current branch"
fi

# unpushed.diff を作成
if git rev-parse --abbrev-ref @{u} >/dev/null 2>&1; then
  # push 済みブランチの (upstream が設定されている) 場合、upstream との差分を出力
  git diff @{u}..HEAD > "$DIFF_DIR/unpushed.diff"
  echo "Created unpushed.diff using @{u}"
else
  # 未 push ブランチの (upstream が設定されていない) 場合、base-branch に書かれた親ブランチとの差分を出力
  BASE=$(cat "$DIFF_DIR/base-branch")
  git diff $BASE..HEAD > "$DIFF_DIR/unpushed.diff"
  echo "Created unpushed.diff using $BASE"
fi
