function aws-profile
    if test (count $argv) -eq 0
        set choice (aws configure list-profiles | fzf --height=10 --reverse --prompt="AWS Profile> ")
        if test -z "$choice"
            echo "No profile selected."
            return 1
        end
        set -gx AWS_PROFILE $choice
    else
        set -gx AWS_PROFILE $argv[1]
    end

    echo "AWS profile set to: $AWS_PROFILE"

    # Try to authenticate
    if aws sts get-caller-identity --profile $AWS_PROFILE >/dev/null 2>&1
        echo (set_color green)"✔ Logged in successfully"(set_color normal)
    else
        echo (set_color yellow)"Session invalid or expired, attempting SSO login..."(set_color normal)
        aws sso login --profile $AWS_PROFILE
        or begin
            echo (set_color red)"✘ SSO login failed for $AWS_PROFILE"(set_color normal)
            return 1
        end
    end
end

