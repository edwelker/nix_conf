#!/usr/bin/env bash
set -e

echo "Installing Node-based CLI tools..."
# Datadog CI
npm install -g @datadog/datadog-ci

# Confluence CLI
npm install -g confluence-cli

echo "Configuring Claude MCP for AWS..."
claude mcp add-json aws-mcp --scope user \
  '{"command":"uvx","args":["mcp-proxy-for-aws@latest","https://aws-mcp.us-east-1.api.aws/mcp"]}'

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

if ! grep -q "source ~/.config/jira.conf" ~/.zshrc; then
  echo "" >> ~/.zshrc
  echo "# Jira CLI Credentials" >> ~/.zshrc
  echo "[ -f ~/.config/jira.conf ] && source ~/.config/jira.conf" >> ~/.zshrc
  echo "Added Jira config source to ~/.zshrc"
fi

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

echo "Installation complete."
