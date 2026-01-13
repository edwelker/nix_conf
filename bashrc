export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/sanity-lighthouse/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

# Aider with Gemini 2.5 Pro (Stable, good balance)
alias aid="aider --model gemini/gemini-2.5-pro --no-auto-commits"

# Aider with Gemini 3.0 Pro (High reasoning/Architect tasks)
alias aid3="aider --model gemini/gemini-3-pro-preview --no-auto-commits"

# Aider with Gemini 3.0 Flash (Fast/Cheap, good for simple refactors)
alias aidf="aider --model gemini/gemini-3-flash-preview --no-auto-commits"
