set fish_greeting

# Export variable
set -x BW_SESSION (cat ~/.bws-session)

# General
set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1
set -x EDITOR nvim
set -x VISUAL nvim
set -x GOPATH ~/.go
set -x GPG_TTY (tty)

# Paths
test -d /usr/local/go/bin                   ; and set PATH /usr/local/go/bin $PATH
test -d /opt/homebrew/bin                   ; and set PATH /opt/homebrew/bin $PATH
test -d ~/.config/tools                     ; and set PATH ~/.config/tools $PATH

# Aliases
source $HOME/.config/fish/aliases/terraform.fish

alias v "nvim"
alias lg "lazygit"
alias .. 'cd .. ; clear ; k'
alias ... 'cd .. ; cd .. ; clear ; k'
alias dow 'cd ~/Downloads ; clear ; k'
alias doc 'cd ~/Documents ; clear ; k'
alias fr 'source ~/.config/fish/config.fish'
alias ide 'tmux split-window -v -p 20 ; tmux split-window -h -p 50 ; tmux last-pane ; nvim'

# Utils
if command -s gpg-agent 2>&1 > /dev/null
	gpg-connect-agent --quiet /bye 2> /dev/null
	if test $status -eq 1
		pkill -U $USER gpg-agent
		gpg-agent --daemon 2>&1 > /dev/null
	end

	# Use curses based Pinentry
	set -x GPG_TTY (tty)
end
