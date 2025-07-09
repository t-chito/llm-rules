# llm-rules

.claude/ 置き場


## tips

一時ファイルの更新を避けるために、以下を実行しておくと良いです。

```bash
git update-index --skip-worktree .claude/communications/prompt.md
git update-index --skip-worktree .claude/communications/tmp.md
```

ちょっと編集したい場合は以下のようなコマンドで復活させます。

```
git update-index --no-skip-worktree .claude/communications/prompt.md
git update-index --no-skip-worktree .claude/communications/tmp.md
```