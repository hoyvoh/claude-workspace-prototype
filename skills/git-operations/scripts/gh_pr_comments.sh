#!/bin/bash
# Get all comments from a Pull Request
# Usage: gh_pr_comments.sh <pr_number> [owner] [repo]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

PR=$1
OWNER="${2:-$DEFAULT_OWNER}"
REPO="${3:-$DEFAULT_REPO}"

if [ -z "$PR" ]; then
    echo "Usage: gh_pr_comments.sh <pr_number> [owner] [repo]" >&2
    exit 1
fi

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    echo "Error: Owner and repo required. Set DEFAULT_OWNER/DEFAULT_REPO or pass as arguments" >&2
    exit 1
fi

echo "=== PR COMMENTS & REVIEWS ===" >&2
echo "Repository: $OWNER/$REPO" >&2
echo "PR: #$PR" >&2
echo "" >&2

gh pr view "$PR" \
    --repo "$OWNER/$REPO" \
    --json comments,reviews \
    | jq -r '
    {
        general_comments: .comments | map({
            author: .author.login,
            created: .createdAt,
            body: .body
        }),
        review_comments: .reviews | map({
            reviewer: .author.login,
            state: .state,
            submitted: .submittedAt,
            body: .body
        })
    }'