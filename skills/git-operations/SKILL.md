---
name: git-operations
description: "Git/GitHub operations toolkit with configurable domain for search, PR review, and code discovery"
requires:
  tools: [execute_command]
  cli: [gh, git, jq]
---

# Git Operations Toolkit

Comprehensive Git/GitHub operations for code discovery, PR review, and branch management with configurable domain support.

**GitHub CLI**: [cli.github.com](https://cli.github.com/)  
**API Reference**: See `skills/github-discovery/github-api-docs-links.md`

## Prerequisites

```bash
# Required tools
gh       # GitHub CLI
git      # Git version control
jq       # JSON processor

# Authentication
gh auth login
```

## Configuration

**Domain is exposed and configurable** in `config/git-config.sh`:

```bash
# Default GitHub (can be changed to GitHub Enterprise)
export GIT_DOMAIN="github.com"
export GIT_API_URL="https://api.github.com"

# Set default repository (optional)
export DEFAULT_OWNER="your-org"
export DEFAULT_REPO="your-repo"
export DEFAULT_BRANCH="main"
```

## Use Cases

### 1. Find Existing Implementations

Search GitHub before coding to avoid reinventing solutions

### 2. PR Review & Comment Management

Extract PR context, analyze changes, suggest fixes, post comments

### 3. Branch Comparison

Compare branches and review diffs locally

## Quick Start Workflows

### Workflow 1: Find Implementation Before Coding

```bash
# Search for existing implementations
bash scripts/find_existing_impl.sh "JWT authentication"

# Search specific code patterns
bash scripts/gh_search_code.sh "OAuth2 implementation" 15

# Search related repositories
bash scripts/gh_search_repos.sh "language:python oauth stars:>100"
```

### Workflow 2: PR Review with Analysis

```bash
# Step 1: Extract complete PR context for Claude
bash scripts/gh_pr_review_suggest.sh 123 owner repo > pr_context.txt

# Step 2: Claude analyzes the context automatically:
#   - Reviews diff for security, logic, performance issues
#   - Checks if comments have been addressed
#   - Suggests specific fixes with code examples
#   - Generates reply suggestions

# Step 3: Post review comment
bash scripts/gh_pr_reply.sh 123 "Suggested fix for validation..." owner repo
```

### Workflow 3: Branch Comparison

```bash
# Compare two branches (local git)
bash scripts/git_diff_branch.sh main feature-branch

# Get PR diff (via GitHub)
bash scripts/gh_pr_diff.sh 123 owner repo
```

## Scripts Reference

### Search & Discovery

#### find_existing_impl.sh

**Purpose**: Search both code and repositories for existing implementations

**Usage**:

```bash
bash scripts/find_existing_impl.sh <keyword> [code_limit] [repo_limit]
```

**Example**:

```bash
bash scripts/find_existing_impl.sh "JWT authentication" 15 10
```

#### gh_search_code.sh

**Purpose**: Search code across GitHub repositories

**Usage**:

```bash
bash scripts/gh_search_code.sh <query> [limit]
```

**Examples**:

```bash
bash scripts/gh_search_code.sh "OAuth implementation"
bash scripts/gh_search_code.sh "language:python async def" 30
```

#### gh_search_repos.sh

**Purpose**: Search repositories by name, description, topics

**Usage**:

```bash
bash scripts/gh_search_repos.sh <query> [limit]
```

**Examples**:

```bash
bash scripts/gh_search_repos.sh "spring boot"
bash scripts/gh_search_repos.sh "language:python stars:>1000" 20
```

### PR Operations

#### gh_pr_review_suggest.sh

**Purpose**: Extract complete PR context for Claude to analyze and suggest fixes

**Usage**:

```bash
bash scripts/gh_pr_review_suggest.sh <pr_number> [owner] [repo]
```

**Output includes**:

- PR information (title, author, state)
- All changed files
- Complete diff
- Existing comments
- Review comments on code
- Analysis tasks for Claude

#### gh_pr_comments.sh

**Purpose**: Get all comments and reviews from a PR

**Usage**:

```bash
bash scripts/gh_pr_comments.sh <pr_number> [owner] [repo]
```

#### gh_pr_diff.sh

**Purpose**: Get PR diff

**Usage**:

```bash
bash scripts/gh_pr_diff.sh <pr_number> [owner] [repo]
```

#### gh_pr_files.sh

**Purpose**: List changed files with additions/deletions

**Usage**:

```bash
bash scripts/gh_pr_files.sh <pr_number> [owner] [repo]
```

#### gh_pr_reply.sh

**Purpose**: Post a comment to a PR

**Usage**:

```bash
bash scripts/gh_pr_reply.sh <pr_number> <message> [owner] [repo]
```

**Example**:

```bash
bash scripts/gh_pr_reply.sh 123 "Please add unit tests" owner repo
```

### Branch Operations

#### git_diff_branch.sh

**Purpose**: Compare two branches (native git, no API)

**Usage**:

```bash
bash scripts/git_diff_branch.sh <base_branch> <target_branch>
```

**Example**:

```bash
bash scripts/git_diff_branch.sh main feature-auth
```

## Integration with Other Skills

### Investigation Skill (Subagent Pattern)

Use as a **subagent** to find existing implementations:

```bash
# Before implementing, search for examples
bash scripts/find_existing_impl.sh "feature keyword"

# Examine found implementations
bash scripts/gh_search_code.sh "specific pattern"
```

### Review Skill (PR Review Workflow)

Use for comprehensive PR review:

```bash
# 1. Extract PR context
bash scripts/gh_pr_review_suggest.sh 123 owner repo > context.txt

# 2. Analyze with Claude (automatic):
#    - Get list of comments
#    - Cross-reference with code changes
#    - Identify issues and suggest fixes
#    - Generate reply suggestions

# 3. Post review
bash scripts/gh_pr_reply.sh 123 "Reply message" owner repo
```

## API Usage Tip

> **When updating or adding scripts, always reference GitHub API documentation** at `skills/github-discovery/github-api-docs-links.md` to ensure optimal implementation and use of available endpoints.

## Configuration Examples

### Set Default Repository

```bash
export DEFAULT_OWNER="myorg"
export DEFAULT_REPO="myproject"

# Now scripts can be called without owner/repo
bash scripts/gh_pr_diff.sh 123
```

### Use GitHub Enterprise

```bash
export GIT_DOMAIN="github.company.com"
export GIT_API_URL="https://github.company.com/api/v3"

# Scripts will now use enterprise domain
bash scripts/gh_search_code.sh "pattern"
```

## Best Practices

✅ **Search before coding**: Use `find_existing_impl.sh` to avoid reinventing  
✅ **Extract full context**: Use `gh_pr_review_suggest.sh` for comprehensive review  
✅ **Analyze systematically**: Security → Logic → Performance → Style  
✅ **Be specific in reviews**: Reference lines, suggest exact fixes  
✅ **Configure defaults**: Set DEFAULT_OWNER/REPO for faster operations  
✅ **Domain flexibility**: Configure GIT_DOMAIN for enterprise instances

## Quick Reference

| Task                 | Script                               |
| -------------------- | ------------------------------------ |
| Find implementations | `find_existing_impl.sh <keyword>`    |
| Search code          | `gh_search_code.sh <query>`          |
| Search repos         | `gh_search_repos.sh <query>`         |
| Extract PR context   | `gh_pr_review_suggest.sh <pr>`       |
| Get PR comments      | `gh_pr_comments.sh <pr>`             |
| Get PR diff          | `gh_pr_diff.sh <pr>`                 |
| Reply to PR          | `gh_pr_reply.sh <pr> <message>`      |
| Compare branches     | `git_diff_branch.sh <base> <target>` |

---

**Configuration**: `config/git-config.sh`  
**Scripts**: `scripts/`  
**API Reference**: `skills/github-discovery/github-api-docs-links.md`

**Tip**: Always set DEFAULT_OWNER and DEFAULT_REPO in config for shorter commands.
