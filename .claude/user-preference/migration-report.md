# 移植状況レポート

## Summary

| 移植率 | ファイル名                  | 移植先ファイル名          | 移植状況の概要                             |
| ------ | --------------------------- | ------------------------- | ------------------------------------------ |
| 100%   | wrong-writing-style.md      | forbidden-patterns.md     | 全ての禁止パターンを移植完了               |
| 100%   | why-llm-bad.md              | forbidden-patterns.md     | LLM の問題パターンを全て移植               |
| 80%    | force.md                    | forbidden-patterns.md     | フィードバックから主要パターンを抽出       |
| 90%    | writing-pref.md             | personas.md               | ライターペルソナの特徴として移植           |
| 100%   | samples/v1_as-script.md     | quality-output-process.md | Step 2 の参照として明記                    |
| 100%   | samples/v2_as-structured.md | quality-output-process.md | Step 3 の参照として明記                    |
| 70%    | communication-style.md      | multiple files            | 主要原則は移植、詳細は参照扱い             |
| 60%    | llm-interaction-guide.md    | multiple files            | 禁止事項は移植、詳細は参照扱い             |
| 90%    | values-and-criteria.md      | personas.md               | レビュアーペルソナの判断基準として移植     |
| 90%    | thinking-patterns.md        | personas.md               | レビュアーペルソナの思考パターンとして移植 |
| 0%     | work-patterns.md            | -                         | 参考程度、直接使用せず                     |
| 0%     | llm-writing-style-draft.md  | -                         | 参考程度、直接使用せず                     |
| 90%    | CLAUDE.md (該当部分)        | multiple files            | トンマナと密度概念を移植                   |

## 結論

### refs/ ディレクトリの削除可否

```
削除不可能なファイル：
- samples/v1_as-script.md（quality-output-process.md が参照）
- samples/v2_as-structured.md（quality-output-process.md が参照）
- writing-pref.md（personas.md が参照）
- communication-style.md（quality-output-process.md が参照）
- llm-interaction-guide.md（quality-output-process.md が参照）
- values-and-criteria.md（personas.md が参照）
- thinking-patterns.md（personas.md が参照）

削除可能なファイル：
- wrong-writing-style.md（完全移植済み）
- why-llm-bad.md（完全移植済み）
- force.md（必要部分は抽出済み）
- work-patterns.md（使用しない）
- llm-writing-style-draft.md（使用しない）
```

### CLAUDE.md の削除可否

```
削除不可：
- user-preference に関係ない部分（Git、指示の解釈・実行）は残すべき
- トンマナと密度の部分は移植済みだが、全体の文脈で必要
```

## wrong-writing-style.md

### 移植済み内容

- 体言止めの完全禁止
- 動詞の名詞化パターン
- 「〜の＋動作性名詞」パターン
- 「こと」「もの」での逃げの禁止
- 文末処理の規則
- チェックリスト
- 最重要原則

### 移植先

- forbidden-patterns.md のセクション 1 に完全移植

## why-llm-bad.md

### 移植済み内容

- 英語の名詞化構文の直訳癖
- ビジネス文書の悪しき慣習
- 箇条書きの形式的統一への過剰適応
- 「フォーマル = 名詞化」という誤学習

### 移植先

- forbidden-patterns.md のセクション 2 に完全移植

## force.md

### 移植済み内容

- 体言止めの問題
- 目的語や助詞の省略
- ステップを変える実験結果

### 未移植内容

- 生のフィードバックログの詳細
- 個別の会話文脈

### 移植先

- forbidden-patterns.md のセクション 3 に主要パターンを抽出して移植

## writing-pref.md

### 移植済み内容

- 現場の実体験に基づく語り
- 「なぜ」を深掘りする思考プロセス
- 複雑な概念を身近な例で説明
- 批判的思考と建設的な代替案
- 誠実な限界の開示
- チームや組織への視点
- 読者を巻き込む対話的な文体

### 未移植内容

- 具体的な記事の引用例（一部）

### 移植先

- personas.md のライターペルソナに特徴として移植

## samples/v1_as-script.md

### 移植済み内容

- 口語的スタイルの例として参照

### 移植先

- quality-output-process.md の Step 2 で明示的に参照

## samples/v2_as-structured.md

### 移植済み内容

- 構造化スタイルの例として参照

### 移植先

- quality-output-process.md の Step 3 で明示的に参照

## communication-style.md

### 移植済み内容

- 簡潔性の原則
- 推測を避ける
- 冗長な説明を避ける

### 未移植内容

- 質問のレイヤを理解する詳細
- 成功例・失敗例の具体的なケース

### 移植先

- forbidden-patterns.md のセクション 4 に主要パターン
- quality-output-process.md でレビュー時の参照として明記

## llm-interaction-guide.md

### 移植済み内容

- 避けるべきパターン（過剰な親切、学術的説明、曖昧な表現）
- マーケティング的表現の禁止

### 未移植内容

- 段階的な情報提供の詳細
- 作業支援での振る舞いの詳細
- 文章作成・編集での協力方法

### 移植先

- forbidden-patterns.md のセクション 5 に禁止事項
- quality-output-process.md でレビュー時の参照として明記

## values-and-criteria.md

### 移植済み内容

- 実用性 > 理論的正確性
- 具体性 > 抽象性
- 簡潔性 > 網羅性
- ユーザー中心の思考
- 全体最適の視点

### 未移植内容

- 組織・チームに関する価値観の詳細

### 移植先

- personas.md のレビュアーペルソナの判断基準として移植

## thinking-patterns.md

### 移植済み内容

- 構造化と体系化
- メタ認知的アプローチ
- 批判的思考
- 段階的分解

### 未移植内容

- 学習と成長の思考パターン
- コミュニケーションにおける思考の詳細

### 移植先

- personas.md のレビュアーペルソナの思考パターンとして移植

## work-patterns.md

### 移植状況

- 直接移植なし
- 参考程度の扱い

## llm-writing-style-draft.md

### 移植状況

- 直接移植なし
- 参考程度の扱い

## CLAUDE.md

### 移植済み内容

- トンマナ（体言止め、絵文字、アスタリスク強調の禁止）
- 密度の正しい理解（情報量 ÷ 文字数）
- 表形式での要約
- DO/DON'T の形式

### 未移植内容

- Git を使った理解（別の用途）
- 指示の解釈（別の用途）
- 指示の実行（別の用途）

### 移植先

- forbidden-patterns.md にトンマナ関連
- quick-output-template.md に密度概念と表形式
