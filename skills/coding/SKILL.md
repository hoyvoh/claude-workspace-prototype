---
name: coding-implementation
description: "Code implementation following design, conventions, and backward compatibility principles"
requires:
  tools: [read_file, write_to_file, execute_command]
---

# Coding Implementation Guide

Implement code following design documents, coding conventions, and best practices ensuring quality and maintainability.

## Prerequisites

- Design document completed
- Test cases defined
- Development environment ready

## Core Principles

### 1. Backward Compatibility First

- Never break existing APIs
- Deprecate gradually
- Version appropriately
- Support migration paths

### 2. Consistent Naming

- Follow project conventions
- Use meaningful names
- Maintain consistency across codebase

### 3. Scalable Organization

- Modular structure
- Clear separation of concerns
- Easy to extend

### 4. Logic Mapping

- Implement per design document
- Trace requirements to code
- Document deviations

### 5. Self Verification

- Review against design
- Check test coverage
- Validate logic flow

## Workflow

### Step 1: Prepare

**Read design documents**:

```
memory/projects/[project-name]/design/design_doc.md
memory/projects/[project-name]/testing/test_cases/
```

**Load conventions**:

- Coding standards: `docs/coding-conventions.md`
- Architecture patterns: `docs/architecture-patterns.md`

### Step 2: Implementation

**Follow structure**:

```
src/
├── controllers/     # API endpoints
├── services/        # Business logic
├── repositories/    # Data access
├── models/          # Data models
└── utils/           # Shared utilities
```

### Step 3: Backward Compatibility Check

✅ **Before committing**:

- Existing tests still pass
- No breaking API changes
- Migration path documented
- Deprecation notices added

### Step 4: Self-Check Loop

**Review checklist**:

1. ✅ Matches design document
2. ✅ Follows naming conventions
3. ✅ Proper error handling
4. ✅ Logging added
5. ✅ Comments for complex logic
6. ✅ No hardcoded values
7. ✅ Unit tests written
8. ✅ Integration points tested

## Coding Standards

**Reference**: `docs/coding-conventions.md`

**Key points**:

- Consistent indentation
- Clear variable names
- Function documentation
- Error handling patterns
- Logging guidelines

## Quality Gates

### Before Commit

- Code compiles/runs
- Unit tests pass
- Linting passes
- Self-review completed

### Before PR

- Integration tests pass
- Documentation updated
- Changelog entry added
- Design doc traced

## Output Structure

```
memory/projects/[project-name]/coding/
├── implementation_log.md    # What was implemented
├── deviations.md            # Any design deviations
└── self_review.md           # Self-review notes
```

## Quick Reference

| Aspect        | Rule                | Check                    |
| ------------- | ------------------- | ------------------------ |
| Compatibility | No breaking changes | Existing tests pass      |
| Naming        | Follow conventions  | Consistent with codebase |
| Organization  | Modular & scalable  | Clear separation         |
| Traceability  | Maps to design      | Requirements covered     |

---

**Next**: `skills/review/SKILL.md` for code review
