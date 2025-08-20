# Claude Agents System Documentation

## プロジェクト概要

`.claude/agents/` ディレクトリには、特定の専門領域に特化したサブエージェント群が含まれています。これらのエージェントはClaude Codeの機能を拡張し、特定のタスクに対してより精度の高い処理を提供します。各エージェントは独立して動作し、タスクの種類や複雑さに応じて組み合わせて使用します。

技術スタック
- Claude Code Agent System (Markdown configuration format)
- 各エージェントは複数のLLMモデル（Opus, Sonnet）を使用
- 豊富なツールセット（ファイル操作、検索、Web fetch等）

主な目的
- タスク固有の専門性を提供
- ワークフローの効率化と品質向上
- 複雑な作業の段階的処理

## ディレクトリ構造

```
.claude/agents/
├── agent-fixer.md              # エージェント修正・デバッグ
├── directory-readme-generator.md  # README生成・文書化
├── git-context-analyzer.md     # Git状態分析
├── japanese-translator.md      # 日本語翻訳
├── requirements-clarifier.md   # 要件明確化
└── semantic-diff-analyzer.md   # 意味的差分分析
```

## エージェント詳細説明

### 1. Agent Fixer (`agent-fixer.md`)
目的: 既存のサブエージェントが期待通りに動作しない場合のデバッグと修正

主な機能:
- エージェント設定ファイルの分析
- 問題の診断（曖昧な指示、ツール指定の誤り、モデル選択の不一致等）
- ユーザー要件に基づく改善提案
- 設定ファイルの更新と品質保証

使用タイミング: 
- 既存エージェントの動作に問題がある場合
- エージェントの機能拡張が必要な場合
- 設定の見直しが必要な場合

モデル: Opus (高度な分析能力が必要)
カラー: 赤

### 2. Directory README Generator (`directory-readme-generator.md`)
目的: ディレクトリ構造を分析し、包括的なREADME文書を生成

主な機能:
- ディレクトリ構造の自動解析
- 技術スタックの識別
- プロジェクトパターンの認識
- 構造化された文書の生成

使用タイミング:
- 新規プロジェクトの文書化
- 既存プロジェクトのREADME作成・更新
- ディレクトリ構造の説明が必要な場合

モデル: Sonnet (構造化された文書生成に最適化されているため)
カラー: 黄

### 3. Git Context Analyzer (`git-context-analyzer.md`)
目的: Git リポジトリの現在状態を分析し、安全な変更操作をサポート

主な機能:
- Git status の詳細分析
- ステージング済み・未ステージ変更の識別
- 競合可能性の検出
- 安全な変更手順の提案

使用タイミング:
- ファイル変更前の状態確認
- ユーザーの作業と競合する可能性がある場合
- Git ベースのワークフローに沿った操作が必要な場合

モデル: Sonnet
カラー: 青

### 4. Japanese Translator (`japanese-translator.md`)
目的: 英語の技術文書、プロンプト、設定ファイルの日本語翻訳

主な機能:
- 技術文書の高精度翻訳
- 専門用語をカタカナ表記と日本語用語のバランスを保った処理
- 構造化データの書式保持
- 自然な日本語表現への変換

使用タイミング:
- 英語文書の日本語化
- 多言語対応の設定ファイル作成
- エージェント設定の日本語版作成

モデル: Opus (高品質な翻訳が必要)
カラー: 黄

### 5. Requirements Clarifier (`requirements-clarifier.md`)
目的: 曖昧または不完全なユーザーリクエストから明確な要件を抽出

主な機能:
- 要件分析フレームワークの適用
- 戦略的質問による情報収集
- ステークホルダーとコンテキストの明確化
- 実装可能な要件定義の作成

使用タイミング:
- 要求が曖昧な場合
- ビジネスコンテキストが不明な場合
- 複数の解釈が可能な指示を受けた場合

モデル: Opus (高度な分析・推論能力が必要)
カラー: 緑

### 6. Semantic Diff Analyzer (`semantic-diff-analyzer.md`)
目的: テキスト間の意味的等価性を検証し、品質保証を提供

主な機能:
- 意味的差分の精密分析
- 翻訳品質チェック
- 情報完全性の検証
- 構造化された比較結果の提供

使用タイミング:
- 翻訳後の品質確認
- コマンド→エージェント移行時の検証
- LLM出力の一貫性チェック

モデル: Opus (精密な分析が必要)
カラー: 黄

## エージェント間の連携パターン

### 典型的なワークフロー

1. **要件明確化 → 専門処理**
   - Requirements Clarifier で要件を整理
   - 適切な専門エージェントに処理を委譲

2. **Git状態確認 → ファイル操作**
   - Git Context Analyzer で現在状態を確認
   - Directory README Generator でドキュメント更新

3. **作成 → 翻訳 → 検証**
   - 英語でコンテンツ作成
   - Japanese Translator で日本語化
   - Semantic Diff Analyzer で品質確認

4. **エージェント開発サイクル**
   - 新規エージェント作成
   - Agent Fixer で改善・調整
   - 実際の使用での検証・修正

### エージェント選択の判断基準

| 状況 | 推奨エージェント | 理由 |
|------|----------------|------|
| 不明確な要求 | Requirements Clarifier | 要件の明確化が最優先 |
| ファイル変更前 | Git Context Analyzer | 競合回避のため状態確認が必要 |
| README作成 | Directory README Generator | 専門的な文書構造化能力 |
| 英日翻訳 | Japanese Translator | 技術翻訳の専門性 |
| 内容比較 | Semantic Diff Analyzer | 精密な意味分析 |
| エージェント問題 | Agent Fixer | 設定とデバッグの専門性 |

## 使用のベストプラクティス

### エージェント活用時の原則

1. エージェント選択の指針
   - タスクの性質を正確に判断
   - 複数エージェントの組み合わせを検討
   - エージェントの専門性を最大限活用

2. 段階的処理の実施
   - 複雑なタスクは複数段階に分割
   - 各段階でタスクに対応したエージェントを使用
   - 中間結果の検証を実施

3. 品質保証の徹底
   - 重要な変更前にGit状態確認
   - 翻訳後は必ず意味的検証実施
   - エージェント動作に問題があれば即座に修正

### 効率的な運用指針

- 事前準備として Git Context Analyzer で現在状態を把握する
- 要件確認により、不明確な要求はRequirements Clarifier で整理する
- 並行処理により、独立したタスクは複数エージェントで同時実行します
- 継続改善のためAgent Fixer を活用した定期的な設定見直しを行います

## セットアップと使用方法

### 前提条件
- Claude Code環境が適切に設定されていること
- 必要なツールへのアクセス権限があること
- Git リポジトリが初期化されていること（Git関連エージェント使用時）

### 基本的な使用方法

各エージェントはClaude Codeがタスク内容を判断して自動的に起動されますが、次のように明示的に指定することもできます。

```bash
# エージェントを明示的に起動する例
"Use the directory-readme-generator agent to document this project"
"Launch the requirements-clarifier agent to understand this request"
"Invoke the semantic-diff-analyzer agent to compare these files"
```

### 設定のカスタマイズ

エージェント設定をカスタマイズする場合は、次のようにAgent Fixerを使用します。

```bash
"Fix the japanese-translator agent to handle code comments better"
"Update the directory-readme-generator to include dependency graphs"
```

## トラブルシューティング

### よくある問題と解決方法

| 問題 | 症状 | 解決方法 |
|------|------|----------|
| エージェント動作異常 | 期待と異なる結果 | Agent Fixerで設定確認・修正 |
| 翻訳品質の問題 | 不自然な日本語 | Semantic Diff Analyzerで検証後、Japanese Translatorを調整 |
| Git競合 | ファイル変更時のエラー | Git Context Analyzerで事前状態確認 |
| 要件不明確 | 実装方針が決まらない | Requirements Clarifierで要件整理 |

### サポートとメンテナンス

- エージェント設定ファイルは定期的にレビューが必要
- 新しい要件に応じてAgent Fixerによる調整を実施
- 使用パターンの変化に応じてエージェントの追加・削除を検討

このエージェントシステムにより、Claude Codeは各タスクに特化した処理を速やかに実行することができます。各エージェントの特性を理解し、適切に組み合わせることで、高品質な作業成果を効率的に得ることができます。