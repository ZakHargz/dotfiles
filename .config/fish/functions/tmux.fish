# Tmux Helper Functions for fish shell
# Save as ~/.config/fish/functions/tmux.fish
# Then add to your config.fish: source ~/.config/fish/functions/tmux.fish

### -----------------------------
### 🖥 Tmux Session Helpers
### -----------------------------

function ts --description "Start or attach to a tmux session"
    if test (count $argv) -eq 0
        set session_name default
    else
        set session_name $argv[1]
    end

    tmux has-session -t $session_name >/dev/null 2>&1
    if test $status -eq 0
        tmux attach-session -t $session_name
    else
        tmux new-session -s $session_name
    end
end

function tls --description "List all tmux sessions"
    tmux list-sessions
end

function tkill --description "Kill a tmux session"
    if test (count $argv) -eq 0
        echo "Usage: tkill <session_name>"
        return 1
    end
    tmux kill-session -t $argv[1]
    set_color red
    echo "✔ Killed tmux session '$argv[1]'"
    set_color normal
end

function tkilla --description "Kill all tmux sessions"
    tmux list-sessions -F "#{session_name}" | while read session
        tmux kill-session -t $session
        echo "Killed session: $session"
    end
end

function tlast --description "Attach to last tmux session"
    set last (tmux list-sessions -F "#{session_name}" | tail -n1)
    if test -n "$last"
        tmux attach-session -t $last
    else
        echo "No tmux sessions found"
    end
end

### -----------------------------
### 🖥 Tmux Window & Pane Helpers
### -----------------------------

function tsplit --description "Split pane and run a command"
    if test (count $argv) -eq 0
        echo "Usage: tsplit <command>"
        return 1
    end
    tmux split-window -h $argv
end

function trename --description "Rename current tmux window"
    if test (count $argv) -eq 0
        echo "Usage: trename <new_name>"
        return 1
    end
    tmux rename-window $argv[1]
end

function tsend --description "Send a command to a tmux session"
    if test (count $argv) -lt 2
        echo "Usage: tsend <session_name> <command>"
        return 1
    end
    set session_name $argv[1]
    set cmd $argv[2..-1]
    tmux send-keys -t $session_name "$cmd" C-m
end

