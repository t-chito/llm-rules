# llm-rules

$HOME/.claude/ 置き場

## tips

一時ファイルの更新を避けるために、以下を実行しておくと良いです。

```bash
git update-index --skip-worktree $HOME/.claude/user-tools/prompt.md
```

ちょっと編集したい場合は以下のようなコマンドで復活させます。

```
git update-index --no-skip-worktree $HOME/.claude/user-tools/prompt.md
```

## mcp

```
claude mcp add --scope project --transport sse context7 https://mcp.context7.com/sse
claude mcp add --scope project --transport sse deepwiki https://mcp.deepwiki.com/sse
```

- https://github.com/jae-jae/fetcher-mcp
