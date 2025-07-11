#!/bin/bash
# AI運用5原則 Hook
# 標準入力からJSONを読み取る
INPUT=$(cat)

# 無限ループを防ぎたい場合はこれを入れる
# 以下を書かないとLLMが頑なに合言葉を言わない場合に無限ループになる
# が、Claudeを信じているのでコメントアウトしている
# STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')
# if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
#     exit 0
# fi

# トランスクリプトを処理（.jsonl形式に対応）
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path')
if [ -f "$TRANSCRIPT_PATH" ]; then
    # 最後のアシスタントメッセージを一時変数に格納
    LAST_MESSAGES=$(tail -n 100 "$TRANSCRIPT_PATH" | \
        jq -r 'select(.type == "assistant") | .message.content[]? | select(.type == "text") | .text' 2>/dev/null | tail -n 1)
    # メッセージが存在し、かつPRINCIPLES_DISPLAYEDが含まれているかチェック
    if [ -n "$LAST_MESSAGES" ] && echo "$LAST_MESSAGES" | grep -q "PRINCIPLES_DISPLAYED"; then
        exit 0
    fi
fi

# CLAUDE.mdの内容を読み込み
CLAUDE_MD_PATH=".claude/CLAUDE.md"
if [ -f "$CLAUDE_MD_PATH" ]; then
    PRINCIPLES=$(cat "$CLAUDE_MD_PATH")
else
    # CLAUDE.mdが存在しない場合はエラーで終了
    echo '{"decision": "block", "reason": "CLAUDE.md not found"}' >&2
    exit 1
fi

ESCAPED_PRINCIPLES=$(echo "$PRINCIPLES" | jq -Rs .)
cat << EOF
{
  "decision": "block",
  "reason": $ESCAPED_PRINCIPLES
}
EOF
