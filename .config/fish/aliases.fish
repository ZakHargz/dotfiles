# Default generic
alias k 'ls -lah'
alias .. 'cd .. ; clear ; k'
alias ... 'cd .. ; cd .. ; clear ; k'
alias projects 'cd ~/Projects'
alias flutter 'cd ~/Flutter'
alias fr 'source ~/.config/fish/config.fish'

# Development Workflow
alias v 'nvim'
alias nv 'neovide --frame=none'
alias lg 'lazygit'
alias c 'clear'

# Terraform
alias tf='terraform'
alias tfgi='terraform graph | dot -Tpng > graph.png'
