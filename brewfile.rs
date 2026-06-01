# work
brew "python@3.9"
brew "postgresql@16"
brew "uv"
brew "sentry-cli"
brew "jira-cli"
brew "gh"
brew "circleci"
brew "direnv"

# Structural code analysis (like ast-grep)
brew "semgrep"          # Pattern-based security/code analysis
brew "comby"            # Structural search/replace
brew "tokei"            # Fast code statistics
brew "difftastic"       # AST-aware git diff
brew "yq"               # YAML/XML processor (jq for YAML)

# Bonus: Data analysis tools
brew "gron"             # Make JSON greppable
brew "xsv"              # Fast CSV toolkit
brew "hyperfine"        # Command benchmarking
brew "miller"           # CSV/JSON/TSV data processor

# cask
cask "plexamp"
cask "claude-code"
cask "copilot-cli"
cask "visual-studio-code"
cask "rancher"

tap "datadog-labs/pack"
brew "datadog-labs/pack/pup"
