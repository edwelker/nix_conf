export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

# Force upgrade to modern Bash if available (interactive shells only)
if [[ $- == *i* ]] && [[ "$BASH_VERSION" == 3.2* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [ -x /opt/homebrew/bin/bash ]; then
        exec /opt/homebrew/bin/bash --login
    elif [ -x /usr/local/bin/bash ]; then
        exec /usr/local/bin/bash --login
    fi
fi
. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"
