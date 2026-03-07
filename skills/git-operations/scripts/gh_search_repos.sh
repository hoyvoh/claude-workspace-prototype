#!/bin/bash
# Search for repositories on GitHub
# Usage: gh_search_repos.sh <query> [limit]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

QUERY=$1
LIMIT="${2:-20}"

if [ -z "$QUERY" ]; then
    echo "Usage: gh_search_repos.sh <query> [limit]" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  gh_search_repos.sh 'spring boot'" >&2
    echo "  gh_search_repos.sh 'language:python oauth stars:>100' 30" >&2
    exit 1
fi

echo "=== GITHUB REPOSITORY SEARCH ===" >&2
echo "Query: $QUERY" >&2
echo "Limit: $LIMIT" >&2
echo "" >&2

gh search repos "$QUERY" \
    --limit "$LIMIT" \
    --json name,description,url,stargazersCount,language \
    | jq -r '.[] | "Name: \(.name)\n★ Stars: \(.stargazersCount)\nLanguage: \(.language // "N/A")\nDescription: \(.description // "No description")\nURL: \(.url)\n---"'