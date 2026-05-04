#!/bin/bash

### Script connects to jira, grabs all issues related to a user
### and converts it to a text file which can then be selected from

## Only real dependences are Jira, and fzf

# This may seem stoopid, but I really hate trying to get the jira keys right
# and this will prevent me from making typos.

### OKAY, let's start
# Load configuration from ~/.config/jira.conf
config_file="$HOME/.config/jira.conf"
if [ ! -f "$config_file" ]; then
    echo "Config file not found: $config_file"
    echo ""
    echo "Create it with the following content:"
    echo '  export JIRA_HOST=https://your-instance.atlassian.net'
    echo '  export JIRA_EMAIL=you@example.com'
    echo '  export JIRA_API_TOKEN=your-api-token'
    echo ""
    echo "Generate an API token at: https://id.atlassian.com/manage-profile/security/api-tokens"
    exit 1
fi
source "$config_file"

# Validate required config vars are set
if [ -z "$JIRA_HOST" ] || [ -z "$JIRA_EMAIL" ] || [ -z "$JIRA_API_TOKEN" ]; then
    echo "Error: Config file must set JIRA_HOST, JIRA_EMAIL, and JIRA_API_TOKEN"
    exit 1
fi

# Get the current user's username from the $USER environment variable (for cache filenames only)
local_user=$USER

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Clean up cache files older than 7 days
find "$script_dir" -name "${local_user}_results_*.json" -mtime +7 -delete 2>/dev/null
find "$script_dir" -name "jira_key_summary_*.txt" -mtime +7 -delete 2>/dev/null

datetime=$(date '+%Y-%m-%d')
resultsname="${script_dir}/${local_user}_results_${datetime}.json"

# Force refresh if -r or --refresh flag passed
if [ "$1" = "-r" ] || [ "$1" = "--refresh" ]; then
    rm -f "$resultsname" 2>/dev/null
fi

if [ ! -f "$resultsname" ]; then
    jql="jql=creator = currentUser() OR assignee = currentUser() OR comment ~ currentUser() ORDER BY updatedDate DESC, created DESC"
    fields="fields=key,summary"
    maxresults="maxResults=1000"

    # Show debug output only if DEBUG=1 is set
    if [ "$DEBUG" = "1" ]; then
        echo "Requesting from: ${JIRA_HOST}/rest/api/3/search/jql"
        echo "JQL: ${jql}"
        echo ""
    fi

    http_code=$(curl -G -s -w '%{http_code}' --user "${JIRA_EMAIL}:${JIRA_API_TOKEN}" --data-urlencode "$jql" --data-urlencode "$fields" --data-urlencode "$maxresults" "${JIRA_HOST}/rest/api/3/search/jql" -o "${resultsname}")

    # Exit early if request failed
    if [ "$http_code" != "200" ]; then
        echo "Error: API request failed with status $http_code"
        cat "$resultsname"
        rm -f "$resultsname"
        exit 1
    fi
fi

if [ -f "$resultsname" ]; then
    timestamp=$(stat -f %m "$resultsname")
    age=$(( $(date +%s) - $timestamp ))
    hours=$(( $age / 3600 ))
    echo "${resultsname} is $hours hour(s) old."

    echo "$(jq -r '.issues | length' "$resultsname") issues returned"
    echo ""

    jira_text_results="${script_dir}/jira_key_summary_${datetime}.txt"

    jq -r '.issues[] | "\(.key) \(.fields.summary)"' "$resultsname" > "$jira_text_results"

    selected=$(cat "$jira_text_results" | fzf | awk '{print $1}')
    # Copy to clipboard if user made a selection (not ESC)
    if [ -n "$selected" ]; then
        echo "$selected" | pbcopy
        echo "$selected (copied to clipboard)"
        echo "${JIRA_HOST}/browse/${selected}"
    fi
else
    echo "$resultsname could not be found/generated. Failing"
    exit 1
fi
