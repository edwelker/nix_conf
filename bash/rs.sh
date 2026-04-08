# rs specific config/aliases

PG_PATH="/opt/homebrew/opt/postgresql@16/bin"

# If the standard opt path is missing, try to find the actual Cellar path
if [ ! -d "$PG_PATH" ]; then
    CELLAR_PG=$(find /opt/homebrew/Cellar/postgresql@16 -name pg_config -exec dirname {} \;)
    if [ -n "$CELLAR_PG" ]; then
        PG_PATH="$CELLAR_PG"
    fi
fi

export PATH="$PG_PATH:$PATH"
