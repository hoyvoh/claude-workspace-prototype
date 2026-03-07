---
name: code-review
description: "Structured code review based on design, coding standards, incidents, and best practices"
requires:
  tools: [read_file, execute_command]
  mcp: [github]
---

# Code Review Guide

Comprehensive code review process ensuring quality, maintainability, and adherence to standards.

## Prerequisites

- Design document available
- Code changes committed
- Diff analysis ready

## Review Resources

**Access to**:

- `docs/coding-conventions.md` - Coding standards
- `docs/architecture-patterns.md` - Architecture guidelines
- `memory/incidents.md` - Past incidents and lessons
- `docs/best-practices.md` - Best practices catalog

## Workflow

### Step 1: Understand Context

**Read**:

```
memory/projects/[project-name]/design/design_doc.md
memory/projects/[project-name]/coding/implementation_log.md
```

**Analyze diff**:

```bash
git diff main...feature-branch
gh pr diff [pr-number]
```

### Step 1.5: GitHub PR Review Workflow (git-operations skill)

**Use** `git-operations` **skill for comprehensive PR review**:

#### Extract Complete PR Context

```bash
# Get full PR context for Claude to analyze
bash skills/git-operations/scripts/gh_pr_review_suggest.sh 123 owner repo > pr_context.txt
```

**This extracts**:

- PR metadata (title, author, state)
- All changed files with stats
- Complete unified diff
- Existing general comments
- Review comments on specific code lines
- All submitted reviews
- Analysis tasks for Claude

#### Analyze with Claude (Automatic)

Claude will analyze the extracted context:

1. **Get list of comments** and cross-reference with code changes
2. **Review diff for issues**:
   - Security vulnerabilities (SQL injection, XSS, auth bypass)
   - Logic errors and edge cases
   - Performance bottlenecks
   - Resource leaks

3. **Check if comments addressed**: Cross-reference existing feedback with current code
4. **Suggest specific fixes** with code examples
5. **Generate reply suggestions** for each comment

#### Post Review to GitHub

```bash
# Post reply comment
bash skills/git-operations/scripts/gh_pr_reply.sh 123 "Suggested fix..." owner repo

# For detailed review workflow, see skills/git-operations/SKILL.md
```

#### Compare Branches

```bash
# Compare two branches locally
bash skills/git-operations/scripts/git_diff_branch.sh main feature-branch

# Get PR diff
bash skills/git-operations/scripts/gh_pr_diff.sh 123 owner repo
```

**See** `skills/git-operations/SKILL.md` **for complete PR review workflows and all available commands**.

### Step 2: Design Alignment Review

✅ **Verify**:

- Implementation matches design
- All requirements addressed
- No unauthorized deviations
- API contracts followed

### Step 3: Code Quality Review

#### Naming Conventions

- Consistent with codebase
- Meaningful variable names
- Clear function names
- Proper class naming

#### Code Organization

- Proper separation of concerns
- Modular structure
- Reusable components
- Scalable architecture

#### Error Handling

- All error cases covered
- Proper exception handling
- Meaningful error messages
- Logging appropriate

### Step 4: Backward Compatibility Check

❌ **Red flags**:

- Breaking API changes
- Removed public methods
- Changed method signatures
- Modified data structures

✅ **Good practices**:

- Deprecation notices
- Migration guides
- Version bumping
- Backward compatible additions

### Step 5: Security & Performance

**Check for**:

- SQL injection risks
- XSS vulnerabilities
- Authentication/authorization
- Performance bottlenecks
- Resource leaks
- N+1 query issues

### Step 6: Test Coverage Review

✅ **Verify**:

- Unit tests for new code
- Integration tests updated
- Edge cases covered
- Error paths tested

```bash
# Check coverage
npm run test:coverage
# or
pytest --cov=src tests/
```

### Step 7: Incident Prevention

**Cross-reference**:

```
memory/incidents.md
```

**Check for**:

- Similar past mistakes
- Known anti-patterns
- Previous bug patterns
- Performance issues

## Review Checklist

### Architecture (5/5)

- [ ] Follows design document
- [ ] Proper layer separation
- [ ] Dependencies managed
- [ ] Scalable structure
- [ ] Integration points clear

### Code Quality (8/8)

- [ ] Naming conventions followed
- [ ] Code readable & maintainable
- [ ] No code duplication
- [ ] Proper error handling
- [ ] Logging added
- [ ] Comments for complex logic
- [ ] No hardcoded values
- [ ] Dead code removed

### Compatibility (4/4)

- [ ] No breaking changes
- [ ] Existing tests pass
- [ ] Migration path provided
- [ ] Deprecation handled

### Testing (4/4)

- [ ] Unit tests added
- [ ] Integration tests updated
- [ ] Coverage adequate (>80%)
- [ ] All tests pass

### Security & Performance (3/3)

- [ ] No security vulnerabilities
- [ ] Performance acceptable
- [ ] Resource usage optimized

## Review Comments Template

```markdown
## Review Comments

### ✅ Strengths

- Good separation of concerns
- Comprehensive test coverage
- Clear documentation

### ⚠️ Issues Found

#### P0 - Critical

- [File:Line] Breaking API change without deprecation

#### P1 - Major

- [File:Line] Missing error handling for edge case

#### P2 - Minor

- [File:Line] Inconsistent naming convention

### 📝 Suggestions

- Consider extracting common logic into utility function
- Add performance optimization for large datasets

### 💡 Best Practices

- Well-structured code following SOLID principles
- Good use of design patterns
```

## Output

```
memory/projects/[project-name]/review/
├── review_report.md      # Review findings
├── issues.md             # Issues to fix
└── approval.md           # Approval status
```

## Quick Reference

| Aspect   | Check           | Tool             |
| -------- | --------------- | ---------------- |
| Design   | Matches spec    | Design doc       |
| Quality  | Standards       | Linter           |
| Tests    | Coverage        | Coverage tool    |
| Security | Vulnerabilities | Security scanner |

---

**After review**: Update `memory/incidents.md` with new patterns
