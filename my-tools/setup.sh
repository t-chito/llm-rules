# !/bin/bash

sudo chsh $USER -s $(which zsh)

# Linux 前提
sudo apt update

sudo apt install -y npm
sudo apt install -y gh
sudo apt install -y jq

# brew install aku11i/tap/phantom
# npm install -g @aku11i/phantom
# brew install bash-completion@2

# claude code
npm install -g @anthropic-ai/claude-code

# mcp
claude mcp add --scope project --transport sse context7 https://mcp.context7.com/sse
claude mcp add --scope project --transport sse deepwiki https://mcp.deepwiki.com/sse

# textlint
npm install -g textlint
npm install -g @textlint-ja/textlint-rule-preset-ai-writing

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
