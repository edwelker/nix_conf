export DOTDOT="${HOME}/bin/nix_conf"
export DOT=${DOTDOT}

# Detect Homebrew prefix: Apple Silicon uses /opt/homebrew, Intel uses /usr/local
if [[ -f /opt/homebrew/bin/brew ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    export HOMEBREW_PREFIX="/usr/local"
fi

# Force upgrade to modern Bash if available (interactive shells only)
if [[ $- == *i* ]] && [[ "$BASH_VERSION" == 3.2* ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [ -x "${HOMEBREW_PREFIX}/bin/bash" ]; then
        exec "${HOMEBREW_PREFIX}/bin/bash" --login
    fi
fi
. ${DOTDOT}/bash/aliases
. ${DOTDOT}/bash/config
. ${DOTDOT}/bash/env

[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"

