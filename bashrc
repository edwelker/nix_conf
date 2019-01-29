export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/sanity-lighthouse/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
