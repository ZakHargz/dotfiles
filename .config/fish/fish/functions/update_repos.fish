function update_repos --description "Update git repos in a folder (optionally filter by keyword)"
    set base (pwd)
    set keyword $argv[1]

    for dir in (ls -d */ | grep -i "$keyword")
        if test -d "$dir/.git"
            echo ""
            set_color cyan
            echo "🔄 Updating (basename $dir)"
            set_color normal

            cd $dir

            # Handle main/master gracefully
            if git show-ref --verify --quiet refs/heads/main
                git checkout main >/dev/null 2>&1
                git pull
                set keep_branch main
                set_color green
                echo "✔ On branch 'main' and pulled latest"
            else if git show-ref --verify --quiet refs/heads/master
                git checkout master >/dev/null 2>&1
                git pull
                set keep_branch master
                set_color green
                echo "✔ On branch 'master' and pulled latest"
            else
                set_color red
                echo "⚠️  No main/master branch found in $dir"
                set_color normal
                cd $base
                continue
            end

            set_color yellow
            echo "🧹 Cleaning up old branches..."
            set_color normal

            for branch in (git branch | string trim | grep -v "$keep_branch")
                git branch -D $branch >/dev/null 2>&1
                set_color red
                echo "   ✖ Deleted branch: $branch"
                set_color normal
            end

            cd $base
            set_color normal
        end
    end
end

