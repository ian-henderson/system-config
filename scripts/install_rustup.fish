#!/usr/bin/env fish

sudo apt install -y curl

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup default stable

rustup component add rust-analyzer
