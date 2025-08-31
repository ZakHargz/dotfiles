export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git aws terraform zsh-autosuggestions zsh-syntax-highlighting k)
source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/opt/homebrew/bin

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

for func_def in $HOME/.config/zsh/functions/*; do
  source "$func_def"
done

source $HOME/.config/zsh/aliases.zsh
source <(fzf --zsh)
