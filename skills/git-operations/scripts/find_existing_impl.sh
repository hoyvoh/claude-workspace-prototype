#!/bin/bash
# Find existing implementations before coding
# Search both code and repositories for a feature/pattern
# Usage: find_existing_impl.sh <keyword> [code_limit] [repo_limit]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

KEYWORD=$1
CODE_LIMIT="${2:-10}"
REPO_LIMIT="${3:-10}"

if [ -z "$KEYWORD" ]; then
    echo "Usage: find_existing_impl.sh <keyword> [code_limit] [repo_limit]" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  find_existing_impl.sh 'JWT authentication'" >&2
    echo "  find_existing_impl.sh 'OAuth2 implementation' 15 10" >&2
    exit 1
fi

echo "================================================================================"
echo "FINDING EXISTING IMPLEMENTATIONS"
echo "================================================================================"
echo "Keyword: $KEYWORD"
echo "Generated: $(date)"
echo "================================================================================"
echo ""

echo "=== SEARCHING CODE ==="
echo ""
gh search code "$KEYWORD" --limit "$CODE_LIMIT" --json repository,path,url \
    | jq -r '.[] | "Repository: \(.repository.full_name)\nFile: \(.path)\nURL: \(.url)\n---"'
echo ""

echo "=== SEARCHING REPOSITORIES ==="
echo ""
gh search repos "$KEYWORD" --limit "$REPO_LIMIT" --json name,description,url,stargazersCount \
    | jq -r '.[] | "Name: \(.name)\n★ Stars: \(.stargazersCount)\nDescription: \(.description // "No description")\nURL: \(.url)\n---"'
echo ""

echo "================================================================================"
echo "ANALYSIS SUGGESTIONS"
echo "================================================================================"
echo ""
echo "1. Review the most starred repositories"
echo "2. Examine code patterns in top results"
echo "3. Identify common approaches and best practices"
echo "4. Reuse proven implementations when appropriate"
echo ""
echo "================================================================================"