---
name: slack-context-gathering
description: "Gather recent Slack context and discussions for project awareness"
requires:
  mcp: [slack]
---

# Slack Context Gathering

Systematically gather and summarize recent Slack discussions to maintain project context.

## Prerequisites

- Slack MCP configured
- Access to relevant channels

## Workflow

### Step 1: Identify Relevant Channels

**Common channels**:

- #project-[name]
- #engineering
- #incidents
- #releases
- #architecture

### Step 2: Gather Recent Messages

**Time windows**:

- Last 24 hours (daily sync)
- Last 7 days (weekly review)
- Last 30 days (monthly context)

**Slack MCP usage**:

```
SLACK_SEARCH_MESSAGES
channels: ["project-channel", "engineering"]
time_range: "24h"
keywords: ["project-name", "feature-name"]
```

### Step 3: Categorize Information

**Group by**:

#### Decisions Made

- Architecture choices
- Technology selections
- Approach agreements

#### Issues Discussed

- Bugs reported
- Performance concerns
- Integration problems

#### Action Items

- Tasks assigned
- Deadlines set
- Follow-ups needed

#### Context Shared

- Requirements clarified
- Design feedback
- Implementation notes

### Step 4: Summarize Findings

**Template**:

```markdown
# Slack Context Summary

**Period**: [date range]
**Channels**: [list]

## Key Decisions

- [Decision 1]: Rationale
- [Decision 2]: Rationale

## Active Issues

- [Issue 1]: Status
- [Issue 2]: Status

## Action Items

- [ ] [Task 1] - @assignee
- [ ] [Task 2] - @assignee

## Important Context

- [Point 1]
- [Point 2]

## Links

- [Thread 1](slack://...)
- [Thread 2](slack://...)
```

### Step 5: Update Memory

**Save to**:

```
memory/projects/[project-name]/slack-context/
├── daily/
│   └── [YYYY-MM-DD].md
├── weekly/
│   └── [YYYY-Www].md
└── summary.md  # Cumulative
```

## Usage Patterns

### Daily Standup Prep

```
Time range: Last 24h
Focus: Updates, blockers, decisions
```

### Weekly Review

```
Time range: Last 7 days
Focus: Progress, issues, planning
```

### Project Onboarding

```
Time range: Last 30 days
Focus: Context, decisions, patterns
```

## Quick Reference

| Task          | Time Range | Output          |
| ------------- | ---------- | --------------- |
| Daily sync    | 24h        | Quick summary   |
| Weekly review | 7d         | Detailed report |
| Context build | 30d        | Full picture    |

---

**Integration**: Part of `skills/investigation/SKILL.md` workflow
