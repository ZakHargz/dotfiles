function git-dirty --description "Check if git repos in subfolders have uncommitted changes"
    # Usage:
    #   git-dirty                -> checks all git repos in subfolders
    #   git-dirty "service-*"    -> checks only folders matching filter

    set filter "*"
    if test (count $argv) -gt 0
        set filter $argv[1]
    end

    # Print table header
    printf "%-45s %-25s %-10s\n" "Repository" "Branch" "Status"
    echo "--------------------------------------------------------------------------------"

    for dir in (find . -maxdepth 1 -type d -name $filter | sort)
        if test -d "$dir/.git"
            pushd $dir > /dev/null

            # Get branch name (or detached HEAD)
            set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if test "$branch" = "HEAD"
                set branch "(detached)"
            end

            # Check if repo is dirty
            set git_changes (git status --porcelain)
            if test -n "$git_changes"
                set repo_status (set_color red)"dirty"(set_color normal)
            else
                set repo_status (set_color green)"clean"(set_color normal)
            end

            # Print table row
            printf "%-45s %-25s %s\n" $dir $branch $repo_status

            popd > /dev/null
        end
    end
end

alias gd="git-dirty"

