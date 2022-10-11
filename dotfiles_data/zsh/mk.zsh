# md <dir-name> - Create directory and cd into it.
mk() {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# mkgo <dir-name> - Create dir and .go file of <dir-name> name.
mkgo() {
    mk $1
    touch $1.go
}
