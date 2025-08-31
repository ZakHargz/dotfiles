function git-sync --description "Sync mainline branch with origin and rebase current branch"
    set -l dry_run 0
    set -l main_branch ""

    # Parse args
    for arg in $argv
        switch $arg
            case '--dry-run'
                set dry_run 1
            case '*'
                set main_branch $arg
        end
    end

    # Detect mainline branch if not given
    if test -z "$main_branch"
        set -l origin_head (git symbolic-ref -q refs/remotes/origin/HEAD 2>/dev/null)
        if test -n "$origin_head"
            set main_branch (string replace -r '^refs/remotes/origin/' '' -- $origin_head)
        else if git show-ref --verify --quiet refs/heads/main
            set main_branch main
        else if git show-ref --verify --quiet refs/heads/master
            set main_branch master
        else
            echo "❌ Could not determine main branch. Pass it explicitly: git-sync <branch>"
            return 1
        end
    end

    # Helper: run command (respects dry run)
    function _run_cmd --no-scope-shadowing
        if test $dry_run -eq 1
            echo "[dry-run] $argv"
        else
            command $argv
        end
    end

    # Helper: ask y/n
    function _ask --no-scope-shadowing
        set -l prompt $argv[1]
        set -l default "N"
        if test (count $argv) -gt 1
            set default $argv[2]
        end
        read -l -P "$prompt [y/N] " ans
        if test -z "$ans"
            set ans $default
        end
        string match -qr '^[Yy]$' -- $ans
        return $status
    end

    # Ensure inside a git repo
    if not git rev-parse --is-inside-work-tree 2>/dev/null
        echo "❌ Not inside a git repository."
        return 1
    end

    echo "🔄 Fetching latest from origin/$main_branch..."
    _run_cmd git fetch origin $main_branch

    set local_hash (git rev-parse $main_branch)
    set remote_hash (git rev-parse origin/$main_branch)

    if test "$local_hash" = "$remote_hash"
        echo "✅ Local $main_branch is up to date with origin/$main_branch"
    else
        echo "⚠️ Local $main_branch is behind origin/$main_branch"
        if _ask "Pull latest changes into $main_branch?"
            _run_cmd git checkout $main_branch
            _run_cmd git pull --ff-only origin $main_branch
        else
            echo "⏭️ Skipping update of $main_branch"
        end
    end

    set current_branch (git rev-parse --abbrev-ref HEAD)
    if test "$current_branch" = "$main_branch"
        echo "ℹ️ You are on $main_branch — nothing to rebase."
        return 0
    end

    echo "🪵 You are on branch: $current_branch"

    set stash_name "auto-stash-before-rebase-"(date +%s)
    if not git diff-index --quiet HEAD --; or not git diff --cached --quiet
        echo "⚠️ You have local changes."
        if _ask "Do you want to stash them before rebasing?"
            _run_cmd git stash push -u -m $stash_name
            set stashed 1
        else
            echo "❌ Cannot safely rebase with dirty state. Exiting."
            return 1
        end
    else
        set stashed 0
    end

    if _ask "Rebase $current_branch onto $main_branch now?"
        echo "🔀 Rebasing $current_branch onto $main_branch..."
        if not _run_cmd git rebase $main_branch
            echo "❌ Rebase failed. Resolve conflicts and then run:"
            echo "   git rebase --continue"
            if test $stashed -eq 1
                echo "   # After finishing, restore your stash manually:"
                echo "   git stash list"
                echo "   git stash pop"
            end
            return 1
        end
    else
        echo "⏭️ Rebase skipped."
        return 0
    end

    if test $stashed -eq 1
        if _ask "Rebase complete. Restore stashed changes now?"
            _run_cmd git stash pop --index
        else
            echo "ℹ️ Stash left in list. Use 'git stash list' to see it."
        end
    end

    echo "✅ Branch $current_branch successfully rebased onto $main_branch"
end

