set cargo_bin "$HOME/.cargo/bin"

if test -d $cargo_bin
    fish_add_path $cargo_bin
end

set cargo_env "$HOME/.cargo/env.fish"

if test -e $cargo_env
    source $cargo_env
end
