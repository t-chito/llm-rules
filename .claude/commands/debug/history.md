# history Command (変更履歴の特定)

## 概要

特定のファイルで行われた変更がいつ、どのコミットで行われたのかを特定し、関連する PR 情報も取得するコマンドです。

## 使用方法

ユーザーから以下の情報を受け取ります：

- ファイル名（必須）
- 経緯を知りたい変更の内容（例：A の機能に B の条件分岐が追加されたのはなぜか、など）

## 処理フロー

### 1. 事前確認と調整

```bash
git log --oneline --follow -- <filepath> | wc -l
```

でコミット数を確認し、以下の基準で処理を決定します：
- 少数（~20コミット）: ファイル全体で実行
- 中程度（20-50）: ユーザーに確認
- 多数（50+）: 絞り込み方法を提案

実行後、差分が大きすぎる場合は追加の絞り込み方法をユーザーに相談します。

### 2. 変更履歴の取得

コミット数に応じて以下のいずれかを実行：
- ファイル全体: `git log --patch --follow -- <filepath>`
- 特定行範囲: `git log -L start,end:<filepath>`
- 関数単位: `git log -L :function:<filepath>`
- 期間限定: `git log --patch --since="date" --until="date" -- <filepath>`

### 3. 関連コミットの特定と説明

ユーザーが知りたい変更内容に関するコミットを特定し、以下の形式で出力します：

```markdown
# 変更履歴

- <commit_hash> : <変更内容の概要>
- <commit_hash> : <変更内容の概要>
- <commit_hash> : <変更内容の概要>
```

### 4. PR 情報の取得

特定されたコミットハッシュを使用して、関連する PR 番号とタイトルを取得します：

```bash
commits=(abc123f def456g hij789k)
for commit in "${commits[@]}"; do
  gh api search/issues -f q="$commit type:pr" -q '.items[] | "- #\(.number) [\(.title)](\(.html_url))"'
done
```

### 5. 統合出力

変更履歴と PR 情報を 1 つのファイルにまとめて出力します：

```markdown
# 変更履歴と PR 情報

## 変更履歴

- <commit_hash> : <変更内容の概要>
- <commit_hash> : <変更内容の概要>

## PR 番号とタイトル

- #123 [PR Title 1](URL1)
- #456 [PR Title 2](URL2)
```

## 実行例

ユーザー：「src/components/Button.js で、新しい variant プロパティが追加された経緯を知りたい」

処理：

1. `git log --oneline --follow -- src/components/Button.js | wc -l` でコミット数確認
2. コミット数に応じて適切な git log コマンドを選択・実行
3. variant 関連の変更を含むコミットを特定
4. 各コミットの変更内容を分析・要約
5. gh api を使用して PR 情報を取得
6. 結果を統合して出力

## 注意事項

- コミット数や差分サイズが大きい場合は段階的に絞り込みを提案します
- PR 情報が見つからないコミットについても履歴には含めます
- 変更内容の分析は、ユーザーが指定した観点に焦点を当てます
- 大幅なコード変更や関数名変更では git log -L の追跡が途切れる場合があります
