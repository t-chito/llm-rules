---
description: code review using checklist
---

# review:check command

$ARGUMENTS ディレクトリの issue と PR description と diff を読み、
3 つそれぞれを比較した上で、下記の「レビュー項目」に則ってレビューしてください。

レビュー結果は $ARGUMENTS ディレクトリに review_check.md として書き出してください。

## レビュー項目

- [ ] 目的・方針の適切性
  - 変更内容がビジネス要件・設計仕様と合致しているか
  - そもそもこの実装で解決すべき課題かどうか
- [ ] 実装範囲の妥当性
  - 変更すべきファイル／機能に抜け漏れはないか
  - 不要なファイル／機能の変更が含まれていないか
  - 例外ケースやエラーハンドリング等、考慮すべき項目が網羅されているか
- [ ] ロジックの正しさ
  - 条件分岐やループなど、主要な処理フローが仕様どおり動作するか
  - エッジケース（境界値、異常系）が想定内かどうか
- [ ] 既存機能への影響
  - 後方互換性が保たれているか
  - 他モジュール／サービスとの連携に問題がないか
- [ ] 外部依存の扱い
  - API 呼び出し／DB 操作の引数・戻り値が正しいか
  - タイムアウトや例外時のリトライ設計が適切か
