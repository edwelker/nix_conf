#!/usr/bin/env bash
set -e

# --- Prereq checks ---
for cmd in npm claude uvx; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "ERROR: '$cmd' is not installed or not in PATH. Aborting." >&2
    exit 1
  fi
done

# --- Node-based CLI tools ---
echo "Installing/upgrading Node-based CLI tools..."

npm install -g @datadog/datadog-ci
npm install -g confluence-cli

# --- Claude MCP for AWS ---
echo "Configuring Claude MCP for AWS..."
if claude mcp list 2>/dev/null | grep -q "^aws-mcp"; then
  echo "aws-mcp already configured in Claude MCP, skipping."
else
  claude mcp add-json aws-mcp --scope user \
    '{"command":"uvx","args":["mcp-proxy-for-aws@latest","https://aws-mcp.us-east-1.api.aws/mcp"]}'
fi

# --- Jira CLI config ---
echo "Configuring Jira CLI..."
mkdir -p ~/.config
if [ ! -f ~/.config/jira.conf ]; then
  cat << 'EOF' > ~/.config/jira.conf
export JIRA_HOST="https://YOUR_DOMAIN.atlassian.net"
export JIRA_EMAIL="ewelker@kyruus.com"
export JIRA_API_TOKEN="YOUR_API_TOKEN"
EOF
  echo "Created ~/.config/jira.conf (Update required)"
fi

# --- Confluence CLI config ---
echo "Configuring Confluence CLI..."
mkdir -p ~/.confluence-cli
if [ ! -f ~/.confluence-cli/config.json ]; then
  cat << 'EOF' > ~/.confluence-cli/config.json
{
  "domain": "YOUR_DOMAIN.atlassian.net",
  "apiPath": "/wiki/rest/api",
  "authType": "basic",
  "email": "ewelker@kyruus.com",
  "token": "YOUR_API_TOKEN"
}
EOF
  echo "Created ~/.confluence-cli/config.json (Update required)"
fi

# --- Datadog CLI config ---
echo "Configuring Datadog CLI..."
if [ ! -f ~/.config/datadog.conf ]; then
  cat << 'EOF' > ~/.config/datadog.conf
export DD_API_KEY="YOUR_API_KEY"
export DD_APP_KEY="YOUR_APP_KEY"
export DD_SITE="datadoghq.com"
EOF
  echo "Created ~/.config/datadog.conf (Update required)"
fi

# --- Shell rc additions ---
echo ""
echo "========================================================"
echo "Add the following lines to your shell rc file:"
echo "========================================================"
echo ""
echo "# Jira CLI Credentials"
echo '[ -f ~/.config/jira.conf ] && source ~/.config/jira.conf'
echo ""
echo "# Datadog CLI Credentials (DD_API_KEY, DD_APP_KEY, DD_SITE)"
echo '[ -f ~/.config/datadog.conf ] && source ~/.config/datadog.conf'
echo ""
echo "========================================================"

echo ""
echo "Installation complete."
