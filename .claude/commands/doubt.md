---
description: Critical re-examination and verification of previous outputs
argument-hint [message]
allowed-tools: Write(*.md)
---

# doubt Command

## 概要

直前の Claude の出力に対してユーザーが疑問や不満を持った際に、批判的な再考察や検証・調査を実行するコマンドです。

## 確認対象

- 直前の Claude 出力（コード、分析結果、提案、説明など）
- 特定の部分に対する疑問（$ARGUMENTS で指定された場合）

## 処理フロー

1. 何に対する疑問・不満であるかを明確にする
2. 出力内容を客観的に再検証する
3. 主張や実装の根拠を再確認する
4. 検証結果をもとに回答を修正・改善する
