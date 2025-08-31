function gwork --description "Create branch (if on main), commit, and push"
    # Ensure we’re inside a git repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
    if test $status -ne 0
        set_color red
        echo "❌ Not in a git repo"
        set_color normal
        return 1
    end

    # Get current branch
    set current (git rev-parse --abbrev-ref HEAD)

    # If on main/master, need a new branch
    if test "$current" = "main" -o "$current" = "master"
        if test (count $argv) -ge 1
            set branch $argv[1]
        else
            read -P "🌱 Enter new branch name: " branch
        end
        git checkout -b $branch
        set current $branch
    end

    # Get commit message
    if test (count $argv) -ge 2
        set msg $argv[2]
    else
        read -P "💬 Enter commit message: " msg
    end

    # Stage all changes
    git add -A

    # Commit
    git commit -m "$msg"
    if test $status -ne 0
        set_color red
        echo "⚠️ Commit failed (maybe nothing to commit)"
        set_color normal
        return 1
    end

    # Push (set upstream if first push)
    git push -u origin $current

    set_color green
    echo "✔ Pushed branch '$current' with message: $msg"
    set_color normal
end

