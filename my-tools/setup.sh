# !/bin/bash

sudo chsh $USER -s $(which zsh)

# Linux 前提
sudo apt update

sudo apt install -y npm
sudo apt install -y gh
sudo apt install -y jq

# claude code
npm install -g @anthropic-ai/claude-code
