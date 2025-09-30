# ~/.config/fish/functions/aws-utils.fish
# AWS helper functions with fzf integration

# -----------------------------
# Pick an AWS region
function aws-region --description "Pick an AWS region (fzf if no arg)"
    if test (count $argv) -gt 0
        echo $argv[1]
        return
    end

    set region (aws ec2 describe-regions --query 'Regions[].RegionName' --output text | tr '\t' '\n' | fzf --height=15 --reverse --prompt="AWS Region> ")
    if test -z "$region"
        echo "No region selected." >&2
        return 1
    end
    echo $region
end

# -----------------------------
# List all VPCs
function aws-vpcs --description "List all VPCs in region"
    set region (aws-region $argv[1])
    or return 1

    aws ec2 describe-vpcs \
        --region $region \
        --query 'Vpcs[].{ID:VpcId, CIDR:CidrBlock, State:State}' \
        --output table
end

# -----------------------------
# List all EC2 instances
function aws-instances --description "List all EC2 instances in region"
    set region (aws-region $argv[1])
    or return 1

    aws ec2 describe-instances \
        --region $region \
        --query '
            Reservations[].Instances[].{
                ID:InstanceId,
                Name:Tags[?Key==`Name`]|[0].Value || `-`,
                State:State.Name
            }' \
        --output table
end

# -----------------------------
# SSM into an instance
#

function aws-ssm --description "SSM into an EC2 instance"
    # -----------------------------
    # 1️⃣ Pick region
    if test (count $argv) -ge 1
        set region $argv[1]
    else if set -q AWS_DEFAULT_REGION
        set region $AWS_DEFAULT_REGION
    else
        # Use fzf to pick region dynamically
        set region (aws ec2 describe-regions \
            --query 'Regions[].RegionName' --output text | tr '\t' '\n' | fzf --height=15 --reverse --prompt="AWS Region> ")
        if test -z "$region"
            echo "No region selected." >&2
            return 1
        end
    end

    # -----------------------------
    # 2️⃣ List running instances
    set instances (aws ec2 describe-instances \
        --region $region \
        --filters "Name=instance-state-name,Values=running" \
        --query 'Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value || `-`}' \
        --output text | awk '{print $1 " " $2}')

    if test -z "$instances"
        echo "No running instances found in region $region"
        return 1
    end

    # -----------------------------
    # 3️⃣ Pick instance via fzf if not passed as second argument
    if test (count $argv) -ge 2
        set instance_id $argv[2]
    else
        set instance_id (echo $instances | tr ' ' '\n' | fzf --height=15 --reverse --prompt="Instance> " | awk '{print $1}')
    end

    if test -z "$instance_id"
        echo "No instance selected."
        return 1
    end

    # -----------------------------
    # 4️⃣ Start SSM session
    echo (set_color yellow)"Starting SSM session into $instance_id in $region..."(set_color normal)
    
    # Set a visual indicator for the prompt
    set -gx SSM_SESSION 1

    aws ssm start-session --target $instance_id --region $region

    # Unset the SSM_SESSION variable after the session ends
    set -e SSM_SESSION
end

# -----------------------------
# AWS utilities launcher menu
function aws-utils --description "Interactive AWS utilities menu"
    set choice (printf "vpcs\ninstances\nssm\nlogin/console\nquit" | fzf --height=10 --reverse --prompt="AWS Utils> ")

    switch $choice
        case vpcs
            aws-vpcs $argv
        case instances
            aws-instances $argv
        case ssm
            aws-ssm $argv
        case quit ''
            echo "Bye 👋"
            return 0
    end
end

