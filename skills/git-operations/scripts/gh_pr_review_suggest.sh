#!/bin/bash
# Extract complete PR context for Claude to review and suggest fixes
# Usage: gh_pr_review_suggest.sh <pr_number> [owner] [repo]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

PR=$1
OWNER="${2:-$DEFAULT_OWNER}"
REPO="${3:-$DEFAULT_REPO}"

if [ -z "$PR" ]; then
    echo "Usage: gh_pr_review_suggest.sh <pr_number> [owner] [repo]" >&2
    exit 1
fi

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
    echo "Error: Owner and repo required. Set DEFAULT_OWNER/DEFAULT_REPO or pass as arguments" >&2
    exit 1
fi

echo "================================================================================"
echo "PR REVIEW CONTEXT FOR ANALYSIS"
echo "================================================================================"
echo "Repository: $OWNER/$REPO"
echo "PR: #$PR"
echo "Generated: $(date)"
echo "================================================================================"
echo ""

echo "=== PR INFORMATION ==="
echo ""
gh pr view "$PR" --repo "$OWNER/$REPO" --json title,body,author,state | jq '.'
echo ""

echo "=== FILES CHANGED ==="
echo ""
gh pr view "$PR" --repo "$OWNER/$REPO" --json files | jq -r '.files[] | "\(.path) (+\(.additions)/-\(.deletions))"'
echo ""

echo "=== FULL DIFF ==="
echo ""
gh pr diff "$PR" --repo "$OWNER/$REPO"
echo ""

echo "=== EXISTING COMMENTS ==="
echo ""
gh pr view "$PR" --repo "$OWNER/$REPO" --json comments | jq -r '.comments[] | "Author: \(.author.login)\nCreated: \(.createdAt)\n\(.body)\n---"'
echo ""

echo "=== REVIEW COMMENTS ON CODE ==="
echo ""
gh api "/repos/$OWNER/$REPO/pulls/$PR/comments" \
    --hostname "$GIT_DOMAIN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: $GIT_API_VERSION" \
    | jq -r '.[] | "File: \(.path)\nLine: \(.line // .original_line)\nAuthor: \(.user.login)\nComment: \(.body)\n---"'
echo ""

echo "================================================================================"
echo "ANALYSIS TASKS FOR CLAUDE"
echo "================================================================================"
echo ""
echo "1. Review the diff for potential issues:"
echo "   - Security vulnerabilities (SQL injection, XSS, auth bypass, etc.)"
echo "   - Logic errors and edge cases"
echo "   - Performance bottlenecks"
echo "   - Resource leaks"
echo ""
echo "2. Check if existing comments have been addressed"
echo ""
echo "3. Suggest specific fixes with code examples"
echo ""
echo "4. Generate reply suggestions for each comment"
echo ""
echo "================================================================================"
echo "TO POST REVIEW:"
echo "  bash scripts/gh_pr_reply.sh $PR 'your comment' $OWNER $REPO"
echo "================================================================================"