export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

# Force upgrade to modern Bash if available (interactive shells only)
if [[ $- == *i* ]]; then
    if [[ "$BASH_VERSION" == 3.2* ]] && [ -x /usr/local/bin/bash ]; then
        export BASH_SILENCE_DEPRECATION_WARNING=1
        exec /usr/local/bin/bash --login
    fi
fi
. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"
