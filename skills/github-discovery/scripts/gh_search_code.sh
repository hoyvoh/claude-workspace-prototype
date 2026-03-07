#!/bin/bash
# Search code across GitHub repositories
# Usage: gh_search_code.sh <query> [limit]

QUERY="$1"
LIMIT="${2:-20}"

if [ -z "$QUERY" ]; then
    echo "Usage: gh_search_code.sh <query> [limit]"
    echo ""
    echo "Examples:"
    echo "  gh_search_code.sh 'const express = require'"
    echo "  gh_search_code.sh 'class UserService' 50"
    exit 1
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed"
    echo "Install from: https://cli.github.com/"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    echo "Error: Not authenticated with GitHub"
    echo "Run: gh auth login"
    exit 1
fi

echo "================================================================================"
echo "GITHUB CODE SEARCH"
echo "================================================================================"
echo "Query: $QUERY"
echo "Limit: $LIMIT"
echo "Generated: $(date)"
echo "================================================================================"
echo ""

gh search code "$QUERY" \
    --limit "$LIMIT" \
    --json repository,path,url,textMatches \
    | jq -r '.[] | "Repository: \(.repository.full_name)\nStars: \(.repository.stargazers_count // 0)\nPath: \(.path)\nURL: \(.url)\n\nMatches:\n\(.textMatches[]?.fragment // "No preview")\n\n---\n"'

echo ""
echo "================================================================================"
echo "Search complete!"
echo ""
echo "To fetch a file:"
echo "  python fetch_github_api.py <owner> <repo> <path>"
echo "================================================================================"
