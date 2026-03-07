#!/bin/bash
# Extract complete PR context for Claude to review
# Usage: gh_pr_review_context.sh <owner> <repo> <pr_number>

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"

if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$PR_NUMBER" ]; then
    echo "Usage: gh_pr_review_context.sh <owner> <repo> <pr_number>"
    echo ""
    echo "Example:"
    echo "  gh_pr_review_context.sh facebook react 12345"
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
echo "PULL REQUEST REVIEW CONTEXT"
echo "================================================================================"
echo "Repository: $OWNER/$REPO"
echo "PR Number: #$PR_NUMBER"
echo "Generated: $(date)"
echo "================================================================================"
echo ""

echo "=== PR INFORMATION ==="
echo ""
gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json title,body,author,state,createdAt,updatedAt,labels,assignees,reviewRequests | jq '.'
echo ""

echo "=== FILES CHANGED ==="
echo ""
gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json files | jq -r '.files[] | "\(.path) (\(.additions) additions, \(.deletions) deletions)"'
echo ""

echo "=== FULL DIFF ==="
echo ""
gh pr diff "$PR_NUMBER" --repo "$OWNER/$REPO"
echo ""

echo "=== EXISTING COMMENTS ==="
echo ""
gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json comments | jq -r '.comments[] | "Author: \(.author.login)\nCreated: \(.createdAt)\nComment:\n\(.body)\n---"'
echo ""

echo "=== REVIEW COMMENTS (on code) ==="
echo ""
gh api "/repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    | jq -r '.[] | "File: \(.path)\nLine: \(.line // .original_line)\nAuthor: \(.user.login)\nComment:\n\(.body)\n---"'
echo ""

echo "=== REVIEWS ==="
echo ""
gh pr view "$PR_NUMBER" --repo "$OWNER/$REPO" --json reviews | jq -r '.reviews[] | "Reviewer: \(.author.login)\nState: \(.state)\nSubmitted: \(.submittedAt)\nBody:\n\(.body // "No comment")\n---"'
echo ""

echo "================================================================================"
echo "CONTEXT EXTRACTION COMPLETE"
echo "================================================================================"
echo ""
echo "Next steps for Claude:"
echo "1. Analyze the diff for potential issues"
echo "2. Check if comments have been addressed"
echo "3. Suggest fixes or improvements"
echo "4. Generate review comments"
echo ""
echo "To post a review comment:"
echo "  gh pr comment $PR_NUMBER --repo $OWNER/$REPO --body \"Your comment\""
echo ""
echo "To submit a review:"
echo "  gh pr review $PR_NUMBER --repo $OWNER/$REPO --comment --body \"Your review\""
echo "================================================================================"