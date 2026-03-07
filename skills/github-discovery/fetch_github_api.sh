#!/bin/bash
# GitHub API Content Fetcher - Shell Version
# Fetch file contents from any GitHub repository using gh CLI or curl

OWNER=""
REPO=""
PATH=""
REF="main"
OUTPUT=""
USE_CLI=true

# Show help
show_help() {
    cat << EOF
GitHub API Content Fetcher

Usage: fetch_github_api.sh [OPTIONS]

Options:
  -o, --owner OWNER       Repository owner (required)
  -r, --repo REPO         Repository name (required)
  -p, --path PATH         File path in repository (required)
  -b, --ref REF           Branch/tag/commit (default: main)
  -f, --output FILE       Output file (default: stdout)
  --no-cli                Use curl instead of gh CLI
  -h, --help              Show this help

Examples:
  # Fetch using gh CLI
  fetch_github_api.sh -o spring-projects -r spring-framework -p README.md

  # Fetch from specific branch
  fetch_github_api.sh -o owner -r repo -p src/Main.java -b feature-branch

  # Save to file
  fetch_github_api.sh -o owner -r repo -p file.txt -f output.txt

  # Use curl with token
  export GITHUB_TOKEN=ghp_xxxx
  fetch_github_api.sh -o owner -r repo -p file.txt --no-cli

Environment Variables:
  GITHUB_TOKEN    GitHub personal access token (for curl fallback)
  GH_TOKEN        Alternative token variable

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--owner)
            OWNER="$2"
            shift 2
            ;;
        -r|--repo)
            REPO="$2"
            shift 2
            ;;
        -p|--path)
            PATH="$2"
            shift 2
            ;;
        -b|--ref)
            REF="$2"
            shift 2
            ;;
        -f|--output)
            OUTPUT="$2"
            shift 2
            ;;
        --no-cli)
            USE_CLI=false
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            show_help
            exit 1
            ;;
    esac
done

# Validate required parameters
if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$PATH" ]; then
    echo "Error: Missing required parameters" >&2
    echo "" >&2
    show_help
    exit 1
fi

# Fetch using gh CLI
fetch_with_gh() {
    local endpoint="/repos/$OWNER/$REPO/contents/$PATH"
    
    if [ "$REF" != "main" ]; then
        gh api "$endpoint?ref=$REF" \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            --jq '.content' | base64 -d
    else
        gh api "$endpoint" \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            --jq '.content' | base64 -d
    fi
}

# Fetch using curl
fetch_with_curl() {
    local url="https://api.github.com/repos/$OWNER/$REPO/contents/$PATH"
    local token="${GITHUB_TOKEN:-$GH_TOKEN}"
    
    if [ "$REF" != "main" ]; then
        url="$url?ref=$REF"
    fi
    
    local headers=(
        -H "Accept: application/vnd.github+json"
        -H "X-GitHub-Api-Version: 2022-11-28"
    )
    
    if [ -n "$token" ]; then
        headers+=(-H "Authorization: token $token")
    fi
    
    curl -s "${headers[@]}" "$url" | jq -r '.content' | base64 -d
}

# Main execution
echo "Fetching $OWNER/$REPO/$PATH (ref: $REF)..." >&2

if [ "$USE_CLI" = true ] && command -v gh &> /dev/null; then
    # Try gh CLI first
    CONTENT=$(fetch_with_gh 2>&1)
    if [ $? -ne 0 ]; then
        echo "Warning: gh CLI failed, trying curl..." >&2
        CONTENT=$(fetch_with_curl)
    fi
else
    # Use curl
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is required for curl method" >&2
        echo "Install jq or use gh CLI instead" >& 2
        exit 1
    fi
    CONTENT=$(fetch_with_curl)
fi

# Check if fetch succeeded
if [ -z "$CONTENT" ] || [ "$CONTENT" = "null" ]; then
    echo "Error: Failed to fetch file content" >&2
    exit 1
fi

# Output
if [ -n "$OUTPUT" ]; then
    echo "$CONTENT" > "$OUTPUT"
    echo "Saved to $OUTPUT ($(echo -n "$CONTENT" | wc -c) bytes)" >&2
else
    echo "$CONTENT"
fi

echo "Success!" >&2