---
name: bug-debugging
description: "Step-by-step debugging guide for localizing and fixing bugs based on logs and symptoms"
requires:
  tools: [read_file, execute_command]
  mcp: [slack]
---

# Bug Debugging Guide

Systematic approach to debug, localize, and fix bugs using logs, traces, and diagnostic tools.

## Prerequisites

- Bug report/incident available
- Access to logs
- Development environment ready

## Resources

- `memory/incidents.md` - Past incidents database
- `docs/troubleshooting.md` - Common issues
- Slack MCP for team context

## Debugging Workflow

### Step 1: Gather Information

**Collect**:

- Error messages
- Stack traces
- Reproduction steps
- Environment details
- Recent changes

**Check Slack**:

```
SLACK_SEARCH query: "[error-message] OR [component-name]"
```

### Step 2: Reproduce the Bug

**Create test case**:

- Minimal reproduction steps
- Consistent environment
- Clear success/failure criteria

### Step 3: Isolate the Problem

**Binary search approach**:

1. Identify affected component
2. Narrow down to module
3. Find specific function
4. Locate exact line

**Tools**:

```bash
# Add logging
DEBUG=* npm start

# Run with debugger
node --inspect index.js

# Check specific logs
grep "ERROR" app.log | tail -n 100
```

### Step 4: Analyze Root Cause

**Common patterns**:

- Null/undefined values
- Off-by-one errors
- Race conditions
- Memory leaks
- Configuration issues

**Cross-reference**:

```
memory/incidents.md
```

### Step 5: Fix and Verify

**Steps**:

1. Implement fix
2. Add test case
3. Verify fix works
4. Check for regressions
5. Document findings

### Step 6: Document

**Update**:

```
memory/incidents.md
memory/projects/[project-name]/bugs/[bug-id].md
```

## Debugging Techniques

### Log Analysis

**Add strategic logging**:

```javascript
console.log("Before operation:", data);
performOperation(data);
console.log("After operation:", result);
```

### Stack Trace Analysis

**Read bottom-to-top**:

1. Identify entry point
2. Follow call chain
3. Find first unexpected behavior
4. Locate root cause

### Data Flow Tracing

**Track variable states**:

- Input values
- Transformation steps
- Output values
- Side effects

## Common Bug Patterns

| Pattern        | Symptom               | Solution             |
| -------------- | --------------------- | -------------------- |
| Null reference | NullPointerException  | Add null check       |
| Race condition | Intermittent failure  | Add synchronization  |
| Memory leak    | Growing memory usage  | Fix resource cleanup |
| Off-by-one     | Wrong iteration count | Fix loop bounds      |

## Debugging Checklist

- [ ] Bug reproduced reliably
- [ ] Logs analyzed
- [ ] Stack trace examined
- [ ] Past incidents checked
- [ ] Root cause identified
- [ ] Fix implemented
- [ ] Test case added
- [ ] Regression tested
- [ ] Findings documented

## Output

```
memory/projects/[project-name]/bugs/
├── [bug-id]/
│   ├── bug_report.md      # Initial report
│   ├── investigation.md   # Debugging steps
│   ├── root_cause.md      # Analysis
│   └── fix.md             # Solution
```

## Quick Reference

| Phase     | Action        | Tool        |
| --------- | ------------- | ----------- |
| Gather    | Collect info  | Logs, Slack |
| Reproduce | Test case     | Debug env   |
| Isolate   | Binary search | Logging     |
| Fix       | Implement     | Code + test |

---

**After fix**: Update `memory/incidents.md` with pattern & solution
