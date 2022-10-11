my-accept-line () {
    if [ ${#${(z)BUFFER}} -eq 0 ]; then
        echo
        if git rev-parse --git-dir > /dev/null 2>&1 ; then
            git status
        else
            k
        fi
    fi
    zle accept-line
}

zle -N my-accept-line
bindkey '^M' my-accept-line
