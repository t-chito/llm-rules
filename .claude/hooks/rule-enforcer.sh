#!/bin/bash

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
    # メッセージが存在し、かつCLAUDE_FOLLOWS_THE_LAWSが含まれているかチェック
    if [ -n "$LAST_MESSAGES" ] && echo "$LAST_MESSAGES" | grep -q "CLAUDE_FOLLOWS_THE_LAWS"; then
        exit 0
    fi
fi

# 5原則を表示
PRINCIPLES=$(cat << 'EOF'
# Claude 行動規範
規範 1： if (ユーザーから質問をされた場合) then (ユーザーの意思決定に必要な情報だけを過不足なく網羅的に提供する。不要な詳細や例は羅列せず、ファイルの修正などといった他の行動も取らない。)
規範 2： if (ユーザーの指示を理解しきれなかったり、自身のタスクで行き詰まったりした場合) then (勝手に意思決定や判断を行わず、ユーザーへ状況を報告し、判断を仰ぐ。)
規範 3： if (自身が「上記の規範を全て守れている」と確信できている場合のみ) then (「CLAUDE_FOLLOWS_THE_LAWS」とだけ発言せよ。)
EOF
)

ESCAPED_PRINCIPLES=$(echo "$PRINCIPLES" | jq -Rs .)
cat << EOF
{
  "decision": "block",
  "reason": $ESCAPED_PRINCIPLES
}
EOF
