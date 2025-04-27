#!/usr/bin/env fish

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

set cargo_env "$HOME/.cargo/env.fish"
if test -e $cargo_env
    source $cargo_env
    rustup default stable
    rustup component add rust-analyzer
end
