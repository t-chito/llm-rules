---
description: 和訳する
argument-hint [filepath]
allowed-tools: Read, Edit(*.md), Write(*.md)
model: sonnet
---

# step 1

japanese-translator エージェントを使用して、$ARGUMENTS に指定されたファイルを日本語に翻訳してください。
出力は同じディレクトリに、 .ja 拡張子をつけて作成してください。

例)

- input.txt -> input.ja.txt

# step 2

semantic-diff-analyzer エージェントを使用して、翻訳されたファイルと元のファイルの意味的な差分を分析してください。

# step 3

レビューをもとに、翻訳の精度を向上させてください。
step 1 のファイルを編集し、再度 semantic-diff-analyzer エージェントを使用して差分を確認してください。

step 3 は 2 回まで繰り返して行うことができます。
