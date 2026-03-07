#!/bin/bash
# Search GitHub repositories
# Usage: gh_search_repos.sh <query> [limit]

QUERY="$1"
LIMIT="${2:-20}"

if [ -z "$QUERY" ]; then
    echo "Usage: gh_search_repos.sh <query> [limit]"
    echo ""
    echo "Examples:"
    echo "  gh_search_repos.sh 'express framework'"
    echo "  gh_search_repos.sh 'language:python ml' 30"
    echo "  gh_search_repos.sh 'spring in:name,description' 50"
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
echo "GITHUB REPOSITORY SEARCH"
echo "================================================================================"
echo "Query: $QUERY"
echo "Limit: $LIMIT"
echo "Generated: $(date)"
echo "================================================================================"
echo ""

gh search repos "$QUERY" \
    --limit "$LIMIT" \
    --json name,fullName,description,url,stargazersCount,language,updatedAt,topics \
    | jq -r '.[] | "Name: \(.fullName)\n★ Stars: \(.stargazersCount)\nLanguage: \(.language // "N/A")\nDescription: \(.description // "No description")\nTopics: \(.topics | join(", "))\nURL: \(.url)\nLast Updated: \(.updatedAt)\n\n---\n"'

echo ""
echo "================================================================================"
echo "Search complete!"
echo ""
echo "To explore a repository:"
echo "  gh repo view <owner>/<repo>"
echo "  python fetch_github_api.py <owner> <repo> <file-path>"
echo "================================================================================"