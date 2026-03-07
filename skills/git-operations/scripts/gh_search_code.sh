#!/bin/bash
# Search for code patterns across GitHub
# Usage: gh_search_code.sh <query> [limit]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

QUERY=$1
LIMIT="${2:-20}"

if [ -z "$QUERY" ]; then
    echo "Usage: gh_search_code.sh <query> [limit]" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  gh_search_code.sh 'OAuth implementation'" >&2
    echo "  gh_search_code.sh 'language:python async def' 30" >&2
    exit 1
fi

echo "=== GITHUB CODE SEARCH ===" >&2
echo "Query: $QUERY" >&2
echo "Limit: $LIMIT" >&2
echo "" >&2

gh search code "$QUERY" \
    --limit "$LIMIT" \
    --json repository,path,url \
    | jq -r '.[] | "Repository: \(.repository.full_name)\nPath: \(.path)\nURL: \(.url)\n---"'