#!/bin/bash

# references:
# https://cli.github.com/manual/gh_pr
# https://cli.github.com/manual/gh_pr_view
# https://qiita.com/n_yamada_x_tech/items/b14a333a53b16815b690#comment%E3%81%A8review%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%81%AE%E9%81%95%E3%81%84
# https://github.com/cli/cli/issues/1009

PR_NUMBER=$1

if [ -z "$PR_NUMBER" ]; then
  echo "使用方法: $0 <PR番号>"
  exit 1
fi

PR_DIR="PR_$PR_NUMBER"
mkdir -p "$PR_DIR"

echo "description を取得中..."
gh pr view $PR_NUMBER > "$PR_DIR/description.md"

echo "diff を取得中..."
gh pr diff $PR_NUMBER > "$PR_DIR/diff.diff"

echo "コメントを取得中..." # PR に紐づいたもの
gh pr view --comments $PR_NUMBER > "$PR_DIR/comments.md"
# 見づらいので、各コメントの先頭に連番付きの見出しを入れる
awk '/^author:/{print "\n" "# コメント " ++count "\n\n" $0; next} {print}' "$PR_DIR/comments.md" > "$PR_DIR/comments.tmp" && mv "$PR_DIR/comments.tmp" "$PR_DIR/comments.md"

echo "レビューコメントを取得中..." # ファイルに紐づいたもの
# .in_reply_to_id, .created_at, .id でソート。 in_reply_to_id が null の場合は空文字に変換する
gh api "pulls/$PR_NUMBER/comments" --jq '[.[] | {id: .id, in_reply_to_id: .in_reply_to_id, reviewer: .user.login, body: .body, path: .path, created_at: .created_at}] | sort_by([if .in_reply_to_id == null then 0 else .in_reply_to_id end, .id])' > "$PR_DIR/review_comments_.json"

echo "完了しました。すべての情報は $PR_DIR に保存されています。"
