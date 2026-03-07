---
name: github-discovery
description: "Discover code, repositories, and perform PR reviews using GitHub API and CLI"
requires:
  tools: [execute_command]
  interpreters: [python, bash]
  cli: [gh, jq]
---

# GitHub Discovery & PR Review Skill

Automate GitHub code discovery, repository exploration, and pull request review workflows using GitHub API and CLI.

**GitHub API Docs**: [docs.github.com/en/rest](https://docs.github.com/en/rest)  
**GitHub CLI**: [cli.github.com](https://cli.github.com/)

## Prerequisites

- **GitHub CLI (`gh`)** - Required for all operations
- **jq** - JSON processor for parsing API responses
- **Python 3.x** - For fetching file contents
- **GitHub Authentication** - Run `gh auth login`

### Installation

```bash
# Install GitHub CLI
# Mac: brew install gh
# Windows: winget install GitHub.cli
# Linux: See https://github.com/cli/cli#installation

# Install jq
# Mac: brew install jq
# Windows: winget install jqlang.jq
# Linux: apt-get install jq  or  yum install jq

# Authenticate
gh auth login
```

## Use Cases

### 1. Code Discovery & Investigation

**Find existing implementations before coding**:

- Search for code patterns across GitHub
- Find similar implementations
- Discover best practices
- Reuse proven solutions

### 2. Repository Exploration

**Research frameworks and libraries**:

- Search repositories by technology
- Compare options by stars/activity
- Read documentation from repos
- Extract specific files for analysis

### 3. Pull Request Review

**Comprehensive code review workflow**:

- Extract complete PR context (diff, comments, reviews)
- Analyze changes for potential issues
- Generate review comments
- Suggest fixes and improvements
- Post reviews back to GitHub

## Quick Start

### Workflow 1: Search for Existing Implementation

```bash
# Step 1: Search for code implementing a feature
bash scripts/gh_search_code.sh "OAuth authentication implementation" 20

# Step 2: Search for related repositories
bash scripts/gh_search_repos.sh "language:python oauth" 15

# Step 3: Fetch a promising file to analyze
python fetch_github_api.py <owner> <repo> src/auth/oauth.py
```

### Workflow 2: Pull Request Review

```bash
# Step 1: Extract complete PR context
bash scripts/gh_pr_review_context.sh facebook react 12345 > pr_context.txt

# Step 2: Claude analyzes the context (automatically)
# - Reviews diff for issues
# - Checks if comments are addressed
# - Suggests improvements

# Step 3: Post review comment
gh pr comment 12345 --repo facebook/react --body "Suggested fix: ..."

# Step 4: Submit full review
gh pr review 12345 --repo facebook/react --comment --body "Overall LGTM with minor suggestions"
```

### Workflow 3: Branch Comparison & Review

```bash
# Compare two branches
gh api "/repos/{owner}/{repo}/compare/main...feature-branch" | jq '.'

# Get diff for review
gh pr diff <pr_number> --repo <owner>/<repo>
```

## Scripts Reference

### 1. Code Search

**Script**: `scripts/gh_search_code.sh`

**Purpose**: Search across all GitHub code

**Usage**:

```bash
bash scripts/gh_search_code.sh <query> [limit]
```

**Examples**:

```bash
# Search for specific code pattern
bash scripts/gh_search_code.sh "class UserService" 20

# Search in specific language
bash scripts/gh_search_code.sh "language:python async def main" 30

# Search for React hooks implementation
bash scripts/gh_search_code.sh "useState useEffect" 50
```

**Output**: Repository name, file path, code matches, URL

### 2. Repository Search

**Script**: `scripts/gh_search_repos.sh`

**Purpose**: Find repositories by criteria

**Usage**:

```bash
bash scripts/gh_search_repos.sh <query> [limit]
```

**Examples**:

```bash
# Find Spring Boot projects
bash scripts/gh_search_repos.sh "spring boot" 20

# Find Python ML libraries
bash scripts/gh_search_repos.sh "language:python machine-learning" 30

# Find popular React frameworks
bash scripts/gh_search_repos.sh "language:javascript react stars:>1000" 15
```

**Output**: Repository name, stars, language, description, last update

### 3. Fetch File Content

**Scripts**: `fetch_github_api.py` | `fetch_github_api.sh`

**Purpose**: Get file contents from any GitHub repository

**Usage**:

```bash
# Python version (feature-rich)
python fetch_github_api.py <owner> <repo> <path> [--ref branch] [-o file]

# Shell version (lightweight)
bash fetch_github_api.sh -o <owner> -r <repo> -p <path> [-b branch] [-f file]
```

**Quick Examples**:

```bash
# Fetch README
python fetch_github_api.py spring-projects spring-framework README.md
bash fetch_github_api.sh -o spring-projects -r spring-framework -p README.md

# Save to file
python fetch_github_api.py owner repo src/Main.java -o Main.java
bash fetch_github_api.sh -o owner -r repo -p src/Main.java -f Main.java
```

### 4. PR Review Context Extraction

**Script**: `scripts/gh_pr_review_context.sh`

**Purpose**: Extract complete PR information for review

**Usage**:

```bash
bash scripts/gh_pr_review_context.sh <owner> <repo> <pr_number>
```

**Example**:

```bash
# Extract PR #12345 from facebook/react
bash scripts/gh_pr_review_context.sh facebook react 12345 > pr_review.txt
```

**Output Includes**:

- PR metadata (title, author, labels, status)
- List of changed files
- Complete diff
- Existing comments (general)
- Review comments (on specific lines)
- Reviews (approve/request changes/comment)
- Suggested next steps

## Integration with Other Skills

**Investigation**: Search GitHub before implementing (see `skills/investigation/SKILL.md`)  
**Review**: GitHub PR review workflow (see `skills/review/SKILL.md`)

## API Reference

**Complete documentation**: `github-api-docs-links.md` (40+ categories, all endpoints)

**Key endpoints**: Search, PRs, Repos, Git Data, Reviews (see `github-api-docs-links.md` for details)

## Best Practices

✅ **Specific search queries**: `"class UserService implements"` > `"user"`  
✅ **Filter by qualifiers**: `language:python`, `stars:>100`, `filename:package.json`  
✅ **Extract complete PR context**: Use `gh_pr_review_context.sh`  
✅ **Review systematically**: Security → Logic → Performance → Style  
✅ **Respect rate limits**: 5000/hour authenticated, 30/min for search  
✅ **Use gh CLI**: Auto-handles auth, use shell scripts for lightweight ops

## Rate Limits

- **Authenticated**: 5000/hour, Search: 30/min
- **Unauthenticated**: 60/hour, Search: 10/min
- **Check status**: `gh api rate_limit`

## Troubleshooting

**Auth issues**: `gh auth status` → `gh auth login`  
**Rate limits**: `gh api rate_limit` → wait or authenticate  
**Missing jq**: `brew install jq` (Mac), `apt-get install jq` (Linux), `winget install jqlang.jq` (Windows)

## Quick Reference

| Task          | Command                                               |
| ------------- | ----------------------------------------------------- |
| Search code   | `bash scripts/gh_search_code.sh "pattern"`            |
| Search repos  | `bash scripts/gh_search_repos.sh "query"`             |
| Fetch file    | `python fetch_github_api.py owner repo path`          |
| PR context    | `bash scripts/gh_pr_review_context.sh owner repo pr#` |
| Post comment  | `gh pr comment <pr#> --repo owner/repo --body "..."`  |
| Submit review | `gh pr review <pr#> --repo owner/repo --approve`      |

---

**GitHub API Docs**: https://docs.github.com/en/rest  
**GitHub CLI Docs**: https://cli.github.com/manual/  
**API Reference**: `github-api-docs-links.md`  
**Scripts**: `scripts/`

**Tip**: Always reference `github-api-docs-links.md` when updating or adding new scripts to ensure you're using the latest API endpoints and best practices.
