#!/bin/bash
# Reply to a Pull Request with a comment
# Usage: gh_pr_reply.sh <pr_number> <message> [owner] [repo]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

PR=$1
MESSAGE=$2
OWNER="${3:-$DEFAULT_OWNER}"
REPO="${4:-$DEFAULT_REPO}"

if [ -z "$PR" ] || [ -z "$MESSAGE" ]; then
    echo "Usage: gh_pr_reply.sh <pr_number> <message> [owner] [repo]" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  gh_pr_reply.sh 123 'LGTM!'" >&2
    echo "  gh_pr_reply.sh 123 'Please fix the validation logic' owner repo" >&2
    exit 1
fi

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    echo "Error: Owner and repo required. Set DEFAULT_OWNER/DEFAULT_REPO or pass as arguments" >&2
    exit 1
fi

echo "Posting comment to PR #$PR in $OWNER/$REPO..." >&2

gh pr comment "$PR" \
    --repo "$OWNER/$REPO" \
    --body "$MESSAGE"

if [ $? -eq 0 ]; then
    echo "✓ Comment posted successfully" >&2
else
    echo "✗ Failed to post comment" >&2
    exit 1
fi