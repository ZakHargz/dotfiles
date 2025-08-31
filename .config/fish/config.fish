. ~/.config/fish/aliases.fish

set -gx fish_greeting ''
set -gx TERM xterm-256color
set -gx EDITOR nvim

function fish_user_key_bindings
  bind \r my-accept-line
end

set -x PATH "/Users/hargrzak/.bun/bin" $PATH
set -x PATH "/Users/hargrzak/bin" $PATH
bass source (brew --prefix nvm)/nvm.sh

# opencode
fish_add_path /Users/hargrzak/.opencode/bin
status is-interactive; and source (pyenv init --path | psub)

source ~/.config/fish/functions/devops.fish
