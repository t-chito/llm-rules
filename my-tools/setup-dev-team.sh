#!/bin/bash
# tmux 開発チーム通信システム

SESSION_NAME="dev-team"

PANES=(
    "architect:アーキテクト"
    "engineer:エンジニア"
    "qa:QA"
    "researcher:リサーチャー"
)

# ```mermaid
# graph TD;
# 	subgraph DevTeam
# 		アーキテクト <-- 設計 --> QA;
# 		アーキテクト <-- 実装 --> エンジニア;	
# 		エンジニア <-- テスト --> QA;
# 	end
# DevTeam <-- 調査 --> リサーチャー;
# ```

# 送信制限ルール（上図に基づく）
declare -A ALLOWED_TARGETS
ALLOWED_TARGETS[architect]="qa engineer researcher"
ALLOWED_TARGETS[engineer]="architect qa"
ALLOWED_TARGETS[qa]="architect engineer"
ALLOWED_TARGETS[researcher]="architect engineer qa"

# tmuxセッションを初期化し、各paneでClaude CLIを起動する
initialize_tmux() {
    tmux kill-session -t $SESSION_NAME 2>/dev/null

    tmux new-session -d -s $SESSION_NAME
    tmux split-window -h -t $SESSION_NAME
    tmux split-window -v -t $SESSION_NAME:0
    tmux split-window -v -t $SESSION_NAME:1

    for i in "${!PANES[@]}"; do
        title=$(echo "${PANES[$i]}" | cut -d: -f2)
        tmux select-pane -t $SESSION_NAME:$i -T "$title"
        tmux send-keys -t $SESSION_NAME:$i "source ~/.claude/user-tools/setup-dev-team.sh" C-m # 関数の定義を読み込む
        tmux send-keys -t $SESSION_NAME:$i "claude --dangerously-skip-permissions" C-m
    done
}

# 送信先からpane番号を取得する（内部関数）
_get_pane() {
    local target=$1
    for i in "${!PANES[@]}"; do
        if [[ "${PANES[$i]}" == "$target:"* ]]; then
            echo $i
            return
        fi
    done
    return 1
}

# 現在のpane番号から送信者の役割を取得する（内部関数）
_get_sender() {
    local current_pane=$(tmux display-message -t "$TMUX_PANE" -p "#{pane_index}")
    if [[ -n "$current_pane" && "$current_pane" -lt "${#PANES[@]}" ]]; then
        echo "${PANES[$current_pane]}" | cut -d: -f1
    else
        return 1
    fi
}

# 送信権限をチェックする（内部関数）
_check_permission() {
    local sender=$1
    local target=$2
    
    if [[ -z "${ALLOWED_TARGETS[$sender]}" ]]; then
        return 1
    fi
    
    if [[ " ${ALLOWED_TARGETS[$sender]} " == *" $target "* ]]; then
        return 0
    else
        return 1
    fi
}

# 指定したpaneにメッセージを送信する
send_message() {
    local target=$1
    local message=$2
    local sender=$(_get_sender)
    local pane_num=$(_get_pane "$target")
    
    if [[ -z "$sender" ]]; then
        echo "❌ 送信者を特定できません"
        return 1
    fi
    
    if [[ -z "$pane_num" ]]; then
        echo "❌ 無効な送信先: $target"
        return 1
    fi
    
    if ! _check_permission "$sender" "$target"; then
        echo "❌ $sender は $target に送信する権限がありません"
        return 1
    fi
    
    tmux send-keys -t $SESSION_NAME:$pane_num "$message" C-m
}

# tmuxセッションを終了する
cleanup_tmux() {
    tmux kill-server 2>/dev/null
    echo "✅ 全tmuxセッションを終了しました"
}

# スクリプトが直接実行された場合は初期化を実行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    initialize_tmux
fi
