# ~/.config/fish/functions/aws-utils.fish
# AWS helper functions with fzf integration

# Define shorthand → full region mappings
set -g region_map \
    "euw1=eu-west-1" \
    "euw2=eu-west-2" \
    "euc1=eu-central-1" \
    "use1=us-east-1" \
    "use2=us-east-2" \
    "usw1=us-west-1" \
    "usw2=us-west-2" \
    "aps1=ap-south-1" \
    "apne1=ap-northeast-1" \
    "apse1=ap-southeast-1" \
    "apse2=ap-southeast-2"


function resolve-region --description "Resolve shorthand region code"
    set short $argv[1]

    for mapping in $region_map
        set parts (string split "=" $mapping)
        set key $parts[1]
        set val $parts[2]

        if test "$short" = "$key"
            echo $val
            return 0
        end
    end

    # If not found, just return original
    echo $short
end

# Pick an AWS region
function aws-region --description "Pick an AWS region (fzf if no arg, or resolve shorthand)"
    if test (count $argv) -gt 0
        echo (resolve-region $argv[1])
        return
    end

    set region (aws ec2 describe-regions --query 'Regions[].RegionName' --output text | tr '\t' '\n' | fzf --height=15 --reverse --prompt="AWS Region> ")
    if test -z "$region"
        echo "No region selected." >&2
        return 1
    end
    echo $region
end

# List all EC2 instances
function aws-instances --description "Pick an EC2 instance and run actions"
    set region (aws-region $argv[1])
    or return 1

    # Pick instance
    set choice (aws ec2 describe-instances \
        --region $region \
        --query 'Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key==`Name`]|[0].Value || `-`,State:State.Name}' \
        --output text \
      | column -t \
      | fzf --height=50% --layout=reverse --border --prompt "Pick EC2 Instance> " --info=inline)

    if test -z "$choice"
        echo "❌ No instance selected"
        return 1
    end

    # Extract instance ID
    set id (string split -f1 " " $choice)

    # Ask what to do with this instance
    set actions "SSM Connect" "Describe Instance" "Security Groups" "Stop Instance ❌" "Quit"
    set action (printf '%s\n' $actions | fzf --prompt "Action for $id> ")

    switch $action
        case "SSM Connect"
            echo "🔌 Starting SSM session with $id in region $region..."
            aws ssm start-session --target $id --region $region

        case "Describe Instance"
            echo "📋 Instance details:"
            aws ec2 describe-instances --instance-ids $id --region $region --output table

        case "Stop Instance"
            echo "🛑 Stopping instance $id..."
            aws ec2 stop-instances --instance-ids $id --region $region

        case "Security Groups"
            # Fetch attached SGs
            set sg_list (aws ec2 describe-instances \
                --instance-ids $id \
                --region $region \
                --query 'Reservations[].Instances[].SecurityGroups[].{ID:GroupId,Name:GroupName}' \
                --output text \
              | column -t \
              | fzf --height=20 --reverse --prompt "Pick Security Group> ")

            if test -z "$sg_list"
                echo "❌ No SG selected"
                return 1
            end

            # Extract SG ID (first column)
            set sg_id (string split -f1 " " $sg_list)

            # Show inbound/outbound rules
            echo "🔒 Rules for $sg_id:"
            aws ec2 describe-security-groups \
                --group-ids $sg_id \
                --region $region \
                --query 'SecurityGroups[].{ID:GroupId,Name:GroupName,Inbound:IpPermissions,Outbound:IpPermissionsEgress}' \
                --output table

        case Quit ''
            echo "Bye 👋"
            return 0
    end
end

# -----------------------------
# AWS utilities launcher menu
# -----------------------------
function sky --description "Interactive AWS utilities menu"
  # Dependencies
  if not type -q fzf
    echo "❌ fzf is required"
    return 1
  end
  if not type -q jq
    echo "❌ jq is required"
    return 1
  end

  set ops "EC2 Instances" 
    set choice (printf '%s\n' $ops | fzf --prompt "Select AWS operation> ")
    if test -z "$choice"
      echo "❌ No operation selected"
      return 1
    end

  switch $choice

    case "EC2 Instances"
      aws-instances $argv 
    case Quit ''
      echo "Bye 👋"
      return 0
    end
end


