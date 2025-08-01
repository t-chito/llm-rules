# Engineering Task Specification - 記入ガイド

## 概要 (Summary)

**目的**: 機能や変更内容を 1 文で簡潔に表現する  
**記入内容**:

- 「何を」「どうする」を明確に
- Epic 分割時や PR 作成時の目的が伝わるように
- 技術的な実装詳細ではなく、ユーザー視点での価値を重視

## 背景・課題 (Background)

**目的**: なぜこの作業が必要なのかを説明する  
**記入内容**:

- 解決したい問題や改善したい状況
- ユーザーの困りごとやペインポイント
- ビジネス上の課題や技術的な問題
- 現状の制約や限界

## 仕様 (Specification)

**目的**: 実装すべき機能の詳細を定義する  
**記入内容**:

### 機能要件

- 何ができるようになるのか（ユーザーから見た動作）
- 入力・処理・出力の詳細
- UI/UX の要件

### 受入条件

- Given-When-Then 形式で具体的な成功条件を記述
- テスト可能で測定可能な条件
- エッジケースや例外パターンも考慮

## 実装方針 (Implementation Approach)

**目的**: 技術的なアプローチと設計判断を明文化する  
**記入内容**:

### 技術的アプローチ

- 使用する技術・ライブラリ・デザインパターン
- アーキテクチャ上の方針
- 既存コードへの影響範囲と変更方針

### 設計判断・代替案検討

- 複数の選択肢がある場合の比較検討
- 選択した方針とその理由
- トレードオフの考慮事項
- 将来への影響や拡張性

## テスト方針 (Testing Strategy)

**目的**: 品質保証の戦略を定義する  
**記入内容**:

- 単体テスト、統合テスト、E2E テストの範囲
- テストデータの準備方法
- 既存テストへの影響
- 手動テストが必要な部分
- パフォーマンステストの要否

## 図・ダイアグラム (Diagrams)

**目的**: 視覚的に設計を伝える  
**記入内容**:

- データモデル・ER 図
- UI フロー・画面遷移
- API 設計・シーケンス図
- システム構成図
- 簡単なテキストベースの図でも可

## 作業リスト (Task Breakdown)

**目的**: 実装を具体的なタスクに分解する  
**記入内容**:

- Phase 別の作業分割
- 各タスクの簡潔な説明
- 工数見積もり（人日単位）
- 依存関係や順序
- 優先度の設定

## 今回考慮しなかった項目

**目的**: 意図的に対象外とした項目を明示する  
**記入内容**:

- なぜ考慮しなかったかの理由
- 将来対応予定のもの
- 他の Epic や Issue で対応するもの
- スコープ外の判断根拠

**よく考慮される項目例**:

- リスク分析（技術的・スケジュール的リスク）
- 非機能要件（パフォーマンス・セキュリティ・可用性）
- 段階的リリース・フィーチャーフラグ
- 監視・ログ・アラート設定
- ロールバック計画
- 運用・保守性の考慮

## 参考資料 (References)

**目的**: 理解や実装に必要な情報源を整理する  
**記入内容**:

- 関連する Epic、Issue、PR へのリンク
- 仕様書・設計書・既存ドキュメント
- API 仕様・ライブラリドキュメント
- 参考記事・ベストプラクティス
- UI モックアップ・デザインファイル

---

## 使い方のコツ

### Epic 分割時

- 「概要」「背景」「仕様」を重点的に記入
- 大まかな「作業リスト」で工数感を把握
- 詳細な実装方針は個別 Issue で決める

### Issue 実装時

- 全セクションを詳細に記入
- 「設計判断」で迷いを解消
- 「テスト方針」で品質を担保

### LLM との協業時

- このテンプレートを提示して仕様整理を依頼
- 不明な点は「考慮しなかった項目」で明示
- 段階的に詳細化していく
