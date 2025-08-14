# 文章生成最適化の実装ガイド

Claude に望ましい文章を生成させるための実装方法をまとめました。即座に実装可能で効果が期待できる方法に絞っています。

## 既存ファイルの活用マップ

| ファイル | 用途 | 新規ファイルへの統合先 |
|----------|------|------------------------|
| wrong-writing-style.md | 禁止事項の基本リスト | → forbidden-patterns.md |
| why-llm-bad.md | LLMが陥るパターン分析 | → forbidden-patterns.md |
| force.md | 実際のフィードバックログ | → forbidden-patterns.md（パターン抽出） |
| writing-pref.md | 良い記事の特徴分析 | → personas.md（ライターペルソナ） |
| samples/v1_as-script.md | 口語的生成の実例 | → quality-output-process.md（Step 2） |
| samples/v2_as-structured.md | 構造化の実例 | → quality-output-process.md（Step 3） |
| communication-style.md | 簡潔性の原則 | → 両テンプレートで参照 |
| llm-interaction-guide.md | 応答の具体的指針 | → quality-output-process.md（レビュー時） |
| values-and-criteria.md | 判断基準 | → personas.md（レビュアーペルソナ） |
| thinking-patterns.md | 思考パターン | → personas.md（レビュアーペルソナ） |
| work-patterns.md | 作業習慣 | （参考程度、直接は使用せず） |
| llm-writing-style-draft.md | プロンプト案 | （参考程度、直接は使用せず） |

### CLAUDE.md からの援用

| 概念 | 活用先 |
|------|--------|
| 密度の正しい理解（情報量÷文字数） | → quick-output-template.md の設計思想 |
| 表形式での要約 | → quick-output-template.md のフォーマット |
| DO/DON'T の具体例形式 | → forbidden-patterns.md の記述形式 |

## 推奨実装

### 核となる手法

**1. 段階的中間生成物アプローチ**
- 最終文章を一度に生成させずに、複数ステップで中間生成物を作る
- 各段階で品質チェックが可能
- samples/v1 → v2 の変換が実証済み

**2. ペルソナ憑依アプローチ**
- 「現場エンジニア」と「批判的レビュアー」の二重人格
- writing-pref.md の分析から抽出した人格を使用
- 書く人とチェックする人の明確な分離

**3. 禁止事項チェックリスト**
- 既存の3ファイルから100項目程度の統合リストを作成
- レビュアーペルソナがこのリストを使用
- 機械的でありながら文脈を考慮

### 具体的な実装手順

#### 1. ディレクトリ再構成

```bash
# 既存ファイルを参照用に移動
mkdir -p .claude/user-preference/refs/
mv *.md refs/  # README.md と approach-proposals.md 以外
mv samples/ refs/

# 新規ファイルを作成
touch forbidden-patterns.md
touch quick-output-template.md
touch quality-output-process.md
touch personas.md
```

#### 2. forbidden-patterns.md の作成

```markdown
# 禁止パターン集

## 文体の絶対禁止事項（refs/wrong-writing-style.md より）
- ❌ 「〜の＋動作性名詞」パターン（例：問題の解決）
- ✅ 動詞形を使う（例：問題を解決する）
[... 50項目程度]

## LLMが陥りやすいパターン（refs/why-llm-bad.md より）
- ❌ 英語の名詞化構文の直訳
- ❌ ビジネス文書の形式的統一
[... 30項目程度]

## 実際のフィードバックから（refs/force.md より）
- ❌ 体言止めの多用
- ❌ 目的語や助詞の省略
[... 20項目程度]
```

#### 3. quick-output-template.md の作成

```markdown
# 使い捨て出力テンプレート

## 設計思想（CLAUDE.md より）
- 情報密度 = 情報量 ÷ 文字数
- 高密度を維持しつつ読みやすく

## 固定フォーマット
【結論】{1行で核心を}
【理由】{3行以内で根拠を}
【詳細】{必要なら箇条書きで}
【次のアクション】{1行で具体的に}

## 使用例
- コードレビュー結果
- 調査結果のまとめ
- 質問への簡潔な回答
```

#### 4. quality-output-process.md の作成

```markdown
# 中長期参照出力の生成プロセス

## Step 1: ペルソナ設定
refs/writing-pref.md の分析結果から：
- 現場で手を動かしているエンジニア
- 実体験に基づいて語る
- 批判的思考を持つ

## Step 2: 草稿生成
refs/samples/v1_as-script.md のように：
- 口語的に、話し言葉で書く
- 「です・ます」調で自然に

## Step 3: 構造化
refs/samples/v2_as-structured.md のように：
- 見出しと段落に整理
- 内容は変えずに構造だけ調整

## Step 4: レビュアーペルソナでチェック
以下の観点で厳密にレビュー：
- forbidden-patterns.md の全項目
- refs/communication-style.md の簡潔性
- refs/llm-interaction-guide.md の原則

## Step 5: 対話的修正
フィードバックを基に改善
```

#### 5. personas.md の作成

```yaml
# ペルソナ定義

writer_persona:
  source: refs/writing-pref.md の分析結果
  特徴:
    - 実践知の重視
    - 思考の透明性  
    - バランス感覚
    - 読者への配慮
  語り口:
    - 実体験を交える
    - 「なぜ」を掘り下げる
    - 複雑な概念を身近な例で説明

reviewer_persona:
  source: 
    - refs/values-and-criteria.md
    - refs/thinking-patterns.md
  チェック項目:
    - forbidden-patterns.md の全項目を照合
    - 論理的整合性の確認
    - 実用性の担保
    - 曖昧表現の排除
  判断基準:
    - 実用性 > 理論的正確性
    - 具体性 > 抽象性
    - 簡潔性 > 網羅性
```

### 最終的なディレクトリ構造

```
.claude/user-preference/
├── README.md                    # 全体説明と現状分析
├── approach-proposals.md        # このファイル（実装ガイド）
├── forbidden-patterns.md        # 統合版禁止事項（100項目）
├── quick-output-template.md     # 使い捨て出力用
├── quality-output-process.md    # 中長期参照用  
├── personas.md                  # ペルソナ定義
└── refs/                        # 参照用の既存ファイル群
    ├── communication-style.md
    ├── force.md
    ├── llm-interaction-guide.md
    ├── llm-writing-style-draft.md
    ├── samples/
    │   ├── v1_as-script.md
    │   └── v2_as-structured.md
    ├── thinking-patterns.md
    ├── values-and-criteria.md
    ├── why-llm-bad.md
    ├── work-patterns.md
    ├── writing-pref.md
    └── wrong-writing-style.md

```

### 運用方法

#### A. 使い捨て出力（速度重視）
**対象**: コードレビュー、調査結果、質問への回答など  
**使用ファイル**: quick-output-template.md のみ
- フォーマットに従って即座に生成
- 禁止事項チェックは最小限

#### B. 中長期参照出力（品質重視）
**対象**: プロダクトビジョン、仕様書、ドキュメントなど  
**使用ファイル**: 
1. personas.md でペルソナを設定
2. quality-output-process.md のプロセスを実行
3. forbidden-patterns.md でチェック

この使い分けにより、スピードと品質の両立が可能になります。