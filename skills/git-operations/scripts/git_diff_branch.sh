#!/bin/bash
# Get diff between two branches (native git, no GitHub API required)
# Usage: git_diff_branch.sh <base_branch> <target_branch>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config/git-config.sh"

BASE=$1
TARGET=$2

if [ -z "$BASE" ] || [ -z "$TARGET" ]; then
    echo "Usage: git_diff_branch.sh <base_branch> <target_branch>" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  git_diff_branch.sh main feature-auth" >&2
    echo "  git_diff_branch.sh develop release-v2.0" >&2
    exit 1
fi

echo "=== BRANCH DIFF ===" >&2
echo "Base: $BASE" >&2
echo "Target: $TARGET" >&2
echo "" >&2

git diff "$BASE..$TARGET"