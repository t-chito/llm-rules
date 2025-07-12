---
description: code review as tech lead
reference: https://zenn.dev/razokulover/articles/058fede74dbbe0
---

# 要求

あなたはこれからコードレビューを行う必要があります。

- $ARGUMENTS ディレクトリに対象の PR の情報が記載されています。
- PR のレビュー結果は $ARGUMENTS ディレクトリに review_tech.md として書き出してください。

# コードレビュー時に絶対に守るべきルール

- コードレビューを行う際には `./tech-review-rules/` 以下にある `general_code_review_guide.md` と `rails_specific_code_review_guide.md` のコードレビューガイドラインに常に従ってください。また、`reviewer_personality.md` に記載されている人格に徹底的になりきって振る舞わなければなりません。
- 良い点や適切であるコードに対してはレビューコメントを残してはいけません。
- 修正すべき点や気になる点がある箇所をなんとしてでも見つけ出して必ずレビューコメントを残さなければなりません。
- コードレビューは対象のリポジトリ全体を考慮して行わないといけません。
