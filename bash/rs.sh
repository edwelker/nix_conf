# rs specific config/aliases

PG_PATH="/opt/homebrew/opt/postgresql@16/bin"

# If the standard opt path is missing, try to find the actual Cellar path
if [ ! -d "$PG_PATH" ]; then
    CELLAR_PG=$(find /opt/homebrew/Cellar/postgresql@16 -name pg_config -exec dirname {} \;)
    if [ -n "$CELLAR_PG" ]; then
        PG_PATH="$CELLAR_PG"
    fi
fi

# aliases
aws_login(){
    aws sso login --profile kyruus
}

[ -f ~/.config/jira.conf ] && source ~/.config/jira.conf
[ -f ~/.config/datadog.conf ] && source ~/.config/datadog.conf

alias co="copilot"
alias cl="claude"

RANCHER_PATH="$HOME/.rd/bin"

export PATH="$RANCHER_PATH:$PG_PATH:$PATH"

# direnv
eval "$(direnv hook bash)"

mvenv(){
    local PY_EXE

    if [ -z "$1" ]; then
        # 1. List Homebrew python@ paths
        # 2. Extract version numbers (e.g., 3.9)
        # 3. Sort numerically (oldest to newest)
        # 4. Prompt with fzf
        local SELECTED_VER=$(ls -d /opt/homebrew/opt/python@* 2>/dev/null | \
                            grep -oE '[0-9]+\.[0-9]+' | \
                            sort -uV | \
                            fzf --header="Select Python version for venv" \
                                --layout=reverse \
                                --height=20%)

        if [ -z "$SELECTED_VER" ]; then
            echo "No version selected."
            return 1
        fi
        PY_EXE="/opt/homebrew/opt/python@${SELECTED_VER}/bin/python${SELECTED_VER}"
    else
        PY_EXE="/opt/homebrew/opt/python@$1/bin/python$1"
    fi

    # Fallback check for Homebrew binary naming conventions
    if [ ! -x "$PY_EXE" ]; then
        local VER_NUM=$(echo "$PY_EXE" | grep -oE '[0-9]+\.[0-9]+')
        PY_EXE="/opt/homebrew/opt/python@${VER_NUM}/bin/python3"
    fi

    # Final fallback to system default if Homebrew path is still invalid
    if [ ! -x "$PY_EXE" ]; then
        echo "Requested version not found on this machine. Using system python3."
        PY_EXE="python3"
    fi

    echo "Creating environment with: $($PY_EXE --version)"

    local TMPDIR=$(mktemp -d)
    pushd . > /dev/null
    cd "$TMPDIR"
    "$PY_EXE" -m venv venv
    source venv/bin/activate

    # Re-apply work-specific paths after venv activation
    if [ -f "${DOTDOT}/bash/rs.sh" ]; then
        . "${DOTDOT}/bash/rs.sh"
    fi

    pip install -r "${DOTDOT}/mvenv_reqs.txt"
    popd > /dev/null

    rm -rf .eggs
    [ -L venv ] || [ -f venv ] && rm venv
    ln -s "$TMPDIR/venv" venv

    if [ -f setup.py ]; then
        pip install -r requirements/test.txt
        pip install -e .
    fi
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt
    fi
}
