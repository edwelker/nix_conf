#!/bin/bash

### OKAY, let's start
# Get the current user's username from the $USER environment variable
username=$USER
jirahost="https://jira.ncbi.nlm.nih.gov"

tokenname="${username}_jira"
filename="${tokenname}.token"

echo "Looking for $filename"

if [ ! -f "$filename" ]; then
    # Prompt the user for a password (without echoing the password to the console)
    read -s -p "Enter the password: " password
    echo ""

    # jira's expected request format to create a token
    data="{\"name\": \"$tokenname\", \"expirationDuration\": 90}"

    curl -X POST "$jirahost/rest/pat/latest/tokens" -H "Content-Type: application/json" -d "$data" --user "$username:$password" -o "$filename"
else
    echo "Found, using existing token"
    echo ""
    # Extract expiration time from JSON file using jq
    expiration=$(jq -r '.expiringAt' $filename)

    # Convert expiration timestamp to Unix timestamp
    expiration_unix=$(date -d "$expiration" +%s)

    # Calculate number of seconds until expiration
    now=$(date +%s)
    time_left=$((expiration_unix - now))

    # Calculate number of days until expiration
    days_left=$((time_left / 86400))

    # Output number of days left until expiration
    echo "There are $days_left days left until the expiration timestamp."
fi

datetime=$(date '+%Y-%m-%d')
resultsname="${username}_results_${datetime}.json"

# because filter permission in our jira is whack
jql="jql=creator = ${username} OR comment ~ ${username} ORDER BY updatedDate DESC, created DESC"
# jql="jql=(creator = ${username} OR assignee = ${username}) ORDER BY updatedDate DESC, created DESC"
# jql="filter=42435"
fields="fields=key,summary"
maxresults="maxResults=5000"

# curl --trace - -G -s -H "Authorization: Bearer $(cat $tokenname)" --data-urlencode "$jql" --data-urlencode "$fields" "$jirahost/rest/api/2/search" -o my_jira_tickets.json #&> /dev/null

# testing with username/password
# read -s -p "Enter the password: " password
# echo ""
# echo "requesting..."
# curl -G -s --user "$username:$password" --data-urlencode "$jql" --data-urlencode "$fields" --data-urlencode "$maxresults" "$jirahost/rest/api/2/search" -o "${resultsname}" &> /dev/null &
# curl_pid=$!
# Wait for the curl process to finish
# wait $curl_pid

jira_text_results="jira_key_summary_${datetime}.txt"

echo "$(jq -r '.issues | length' $resultsname) issues returned"
echo ""
jq -r '.issues[] | "\(.key) \(.fields.summary)"' $resultsname > $jira_text_results

cat $jira_text_results | fzf | awk '{print $1}'
