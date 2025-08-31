# DevOps Helper Functions for fish shell
# Save as ~/.config/fish/functions/devops.fish
# Then add to your config.fish: source ~/.config/fish/functions/devops.fish

### -----------------------------
### 🐳 Docker Helpers
### -----------------------------

function dclean --description "Remove stopped containers, dangling images, and networks"
    docker system prune -af --volumes
    set_color green
    echo "✔ Docker cleaned"
    set_color normal
end

function dlogs --description "Follow logs for a container by name"
    if test (count $argv) -eq 0
        echo "Usage: dlogs <container_name>"
        return 1
    end
    docker logs -f $argv[1]
end

### -----------------------------
### ☸️ Kubernetes Helpers
### -----------------------------

function kctx --description "Switch kubectl context"
    if test (count $argv) -eq 0
        kubectl config get-contexts
    else
        kubectl config use-context $argv[1]
    end
end

function kns --description "Switch namespace"
    if test (count $argv) -eq 0
        kubectl get ns
    else
        kubectl config set-context --current --namespace=$argv[1]
    end
end

function kpods --description "List pods with wide output"
    kubectl get pods -o wide
end

function kl --description "Tail logs from a pod"
    if test (count $argv) -lt 1
        echo "Usage: kl <pod> [container]"
        return 1
    end
    kubectl logs -f $argv
end

### -----------------------------
### 🌍 Terraform Helpers
### -----------------------------

function tinit --description "Terraform init + validate"
    terraform init -upgrade
    terraform validate
end

function tplan --description "Terraform init + plan"
    terraform init -upgrade
    terraform plan $argv
end

function tapply --description "Terraform init + apply"
    terraform init -upgrade
    terraform apply -auto-approve $argv
end

### -----------------------------
### ☁️ AWS Helpers
### -----------------------------

function assume-role --description "Assume an AWS IAM role"
    if test (count $argv) -lt 2
        echo "Usage: assume-role <role-arn> <session-name>"
        return 1
    end

    set creds (aws sts assume-role --role-arn $argv[1] --role-session-name $argv[2] --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" --output text)

    set -gx AWS_ACCESS_KEY_ID (echo $creds | awk '{print $1}')
    set -gx AWS_SECRET_ACCESS_KEY (echo $creds | awk '{print $2}')
    set -gx AWS_SESSION_TOKEN (echo $creds | awk '{print $3}')

    set_color green
    echo "✔ Assumed role: $argv[1]"
    set_color normal
end

### -----------------------------
### 🛠 Git Helpers
### -----------------------------

function gco --description "Checkout branch"
    git checkout $argv
end

function gst --description "Git status short"
    git status -sb
end

function gundo --description "Undo last commit (keep changes)"
    git reset --soft HEAD~1
end

function gamend --description "Amend last commit with staged changes"
    git commit --amend --no-edit
end

### -----------------------------
### 🖥️ System Helpers
### -----------------------------

function ports --description "List processes using TCP ports"
    sudo lsof -iTCP -sTCP:LISTEN -n -P
end

function topcpu --description "Top 10 CPU-hogging processes"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 15
end

function topmem --description "Top 10 memory-hogging processes"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 15
end

