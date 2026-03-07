---
name: project-investigation
description: "Comprehensive project investigation workflow with access to Slack, Confluence, GitHub, and documentation"
requires:
  mcp: [slack, confluence, github]
  tools: [read_file, write_to_file, execute_command]
---

# Project Investigation Guide

Systematic project investigation workflow for understanding requirements, gathering context, and planning implementation.

## Prerequisites

- Slack MCP configured and connected
- Confluence MCP configured and connected
- GitHub CLI access
- Framework documentation indexed

## Investigation Workflow

### Step 1: Find and Read Project RDD

**Goal**: Locate and preserve Requirements & Design Document

```bash
# Search in Confluence
CONFLUENCE_SEARCH query: "RDD [project-name]"

# Or search in GitHub
gh repo search "[project-name] RDD"
```

**Action**: Save to project-specific memory directory

### Step 2: Gather Related Documents

**Sources to check**:

- Architecture documents
- API specifications
- Database schemas
- Previous incident reports
- Related Slack discussions

**Use sub-skills**:

- `slack-context-gathering` - Recent discussions
- `confluence-doc-discovery` - Technical docs
- `github-history-analysis` - Code evolution

### Step 2.5: Search for Existing Implementations (Subagent Pattern)

**Use** `git-operations` **skill as subagent** to find existing implementations before coding:

```bash
# Find existing implementations (searches both code and repos)
bash skills/git-operations/scripts/find_existing_impl.sh "JWT authentication"

# Search specific code patterns
bash skills/git-operations/scripts/gh_search_code.sh "OAuth implementation" 20

# Search related repositories
bash skills/git-operations/scripts/gh_search_repos.sh "language:python auth" 15
```

**What to search**:

- Feature implementations
- Code patterns and best practices
- Repository names and descriptions
- User profiles for expertise
- Text descriptions in documentation

**Benefits**:

- Find proven implementations before coding
- Avoid reinventing solutions
- Learn from real-world examples
- Identify potential libraries to reuse
- Understand common approaches and patterns

**Integration**: The `git-operations` skill provides search tools specifically designed for this investigation phase.

### Step 3: Specify Requirements

**Present to developer**:

- Business requirements
- Technical constraints
- Dependencies
- Success criteria
- **Existing implementations found** (if any)

### Step 4: Propose Solution

**Based on tech stack analysis**:

- Current architecture
- Technology choices
- Integration points
- Trade-offs

### Step 5: Summarize & Task Breakdown

**Output format**:

```markdown
## Task Breakdown

### 1. Detail Design Doc

- **Effort**: X ManDays
- **Dependencies**: RDD, Architecture docs
- **Output**: Design document

### 2. Test Case Doc

- **Effort**: X ManDays
- **Dependencies**: Design doc
- **Output**: Test specification

### 3. Coding

- **Effort**: X ManDays
- **Dependencies**: Design doc, Test cases
- **Output**: Implementation

### 4. Code Review

- **Effort**: X ManDays
- **Dependencies**: Code completion
- **Output**: Review report

### 5. Unit Testing

- **Effort**: X ManDays
- **Dependencies**: Code
- **Output**: Unit tests

### 6. Function Testing

- **Effort**: X ManDays
- **Dependencies**: Unit tests pass
- **Output**: Test results
```

## Sub-Skills

See individual skill guides:

- `skills/investigation/slack-context/` - Slack MCP integration
- `skills/investigation/confluence-discovery/` - Confluence search
- `skills/investigation/github-analysis/` - GitHub investigation

## Memory Management

**Project directory structure**:

```
memory/projects/[project-name]/
├── rdd.md              # Requirements document
├── investigation.md    # Investigation findings
├── related-docs/       # Gathered documents
└── decisions.md        # Key decisions
```

## Quick Reference

| Phase             | Action                   | Tool          |
| ----------------- | ------------------------ | ------------- |
| Find RDD          | Search Confluence/GitHub | MCP/CLI       |
| Gather context    | Search discussions       | Slack MCP     |
| Analyze code      | Review history           | GitHub CLI    |
| Document findings | Save to memory           | write_to_file |

---

**For detailed sub-skills**: See `skills/investigation/[sub-skill]/`
