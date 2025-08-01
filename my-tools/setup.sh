# !/bin/bash

sudo chsh $USER -s $(which zsh)

# Linux 前提
sudo apt update

sudo apt install -y npm
sudo apt install -y gh
sudo apt install -y jq

# claude code
npm install -g @anthropic-ai/claude-code

# textlint
npm install -g textlint
npm install -g @textlint-ja/textlint-rule-preset-ai-writing

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
