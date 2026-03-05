export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

# Force upgrade to modern Bash if available
if [[ "$BASH_VERSION" == 3.2* ]] && [ -x /usr/local/bin/bash ]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    exec /usr/local/bin/bash --login
fi

. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/sanity-lighthouse/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"
