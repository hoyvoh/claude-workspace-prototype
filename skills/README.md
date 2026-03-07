# Skills Directory

Reusable AI agent skills for common development workflows and tasks.

## Overview

Skills are self-contained, documented workflows that can be referenced and executed by AI agents. Each skill provides:

- Clear prerequisites and requirements
- Step-by-step workflow instructions
- Example usage and code snippets
- Best practices and anti-patterns
- Scripts and tools (if needed)

## Directory Structure

```
skills/
├── README.md                          # This file - skills documentation
├── skill-example.md                   # Template for creating new skills
├── coding/                            # Code generation and refactoring skills
├── debugging/                         # Debugging and troubleshooting skills
├── design/                            # Design pattern and architecture skills
├── framework-discovery-guide/         # Framework documentation discovery
├── investigation/                     # Code investigation and analysis skills
├── planning/                          # Project planning and architecture skills
├── review/                            # Code review skills
├── spring-framework-discovery/        # Spring Framework documentation discovery
│   ├── SKILL.md                       # Skill documentation
│   ├── parse_spring_docs.py           # Parser script
│   └── spring-framework-docs-links.md # Sample output
└── testing/                           # Testing strategy and implementation skills
    ├── test-case-document/            # Test case documentation
    └── test-result-review/            # Test result analysis
```

## Creating a New Skill

### 1. Skill Structure

Each skill should be in its own directory with:

```
skill-name/
├── SKILL.md           # Main documentation (REQUIRED, <150 lines)
├── script1.py         # Supporting scripts (optional)
├── script2.sh         # Supporting scripts (optional)
└── examples/          # Example outputs (optional)
```

### 2. SKILL.md Format

````markdown
---
name: skill-name
description: "Brief description of what the skill does"
requires:
  tools: [tool1, tool2] # Optional: Required tools
  mcp: [server1, server2] # Optional: Required MCP servers
  interpreters: [python, node] # Optional: Required interpreters
---

# Skill Name

Brief introduction (1-2 sentences)

**Related Docs**: [link to official docs if applicable]

## Prerequisites

- List all requirements
- Tools, libraries, access
- Environment setup

## Use Cases

- Use case 1: Description
- Use case 2: Description
- Use case 3: Description

## Quick Start

### Step 1: First Action

```bash
command example
```
````

### Step 2: Second Action

```bash
another command
```

## Scripts

### script_name.py

Location: `skills/skill-name/script_name.py`

**Purpose**: What the script does

**Usage**:

```bash
python script_name.py [args]
```

## Best Practices

✅ **Do this**: Explanation
✅ **Do that**: Explanation

## Anti-Patterns

❌ **Don't do this**: Why not
❌ **Don't do that**: Why not

## Quick Reference

| Task  | Command   |
| ----- | --------- |
| Task1 | `command` |
| Task2 | `command` |

---

Additional notes or tips

````

### 3. SKILL.md Rules (IMPORTANT)

**MUST follow these rules:**

1. **Length Limit**: Keep SKILL.md under 150 lines
2. **External Scripts**: Move code to separate files, reference location in SKILL.md
3. **Concise**: Focus on essential information only
4. **Frontmatter**: Always include YAML frontmatter with name, description, requires
5. **Structure**: Follow the template structure above
6. **Examples**: Provide concrete, runnable examples
7. **No Code Dumps**: Don't paste entire scripts in markdown - reference file location

## Finding and Using Skills

### Search by Category

```bash
# List all available skills
ls skills/

# Find skills by category
ls skills/testing/
ls skills/coding/
````

### Search by Content

Use grep or search tools to find specific functionality:

```bash
# Find skills related to "testing"
grep -r "testing" skills/*/SKILL.md

# Find skills that use Python
grep -r "python" skills/*/SKILL.md
```

### Using a Skill

1. Navigate to the skill directory
2. Read SKILL.md for prerequisites and workflow
3. Follow the Quick Start section
4. Reference scripts in the skill directory as needed
5. Adapt examples to your specific use case

## Standard Skill Template

Use `skill-example.md` as your starting template. Key sections:

1. **Frontmatter** (YAML metadata)
2. **Introduction** (brief, 1-2 sentences)
3. **Prerequisites** (requirements)
4. **Use Cases** (when to use this skill)
5. **Quick Start** (step-by-step workflow)
6. **Scripts** (reference to external files)
7. **Best Practices** (✅ recommendations)
8. **Anti-Patterns** (❌ what to avoid)
9. **Quick Reference** (command table)

## Best Practices for Skills

### ✅ Good Practices

- **Clear naming**: Use descriptive, hyphenated names (e.g., `spring-framework-discovery`)
- **Single responsibility**: Each skill focuses on one workflow
- **Reusable scripts**: Place scripts in skill directory, make them generic
- **Concrete examples**: Provide real, working examples
- **Version awareness**: Note version-specific behaviors
- **Update regularly**: Keep skills current with tool changes
- **Test before commit**: Verify all examples work

### ❌ Anti-Patterns

- **Too long**: SKILL.md exceeds 150 lines
- **Too vague**: Missing concrete examples
- **Code dumps**: Pasting entire scripts in markdown
- **No structure**: Not following template format
- **Complex dependencies**: Requiring too many tools/setup
- **Outdated info**: Using deprecated tools or approaches
- **No error handling**: Examples that fail without guidance

## Contributing Skills

When adding a new skill:

1. **Review similar existing skills first** - Ensure consistency and avoid duplication
2. Create directory: `skills/your-skill-name/`
3. Add SKILL.md following template (< 150 lines)
4. **For every Python script, create a parallel shell script** (`.sh`) for environments without Python
5. Add scripts/tools to skill directory
6. Test all examples on multiple platforms
7. Update this README if adding new category
8. Commit with clear message: `feat: add [skill-name] skill`

### Consistency Guidelines

**Before creating a new skill**:

✅ **Review existing similar skills** to maintain consistency:

- Study structure and naming patterns
- Check if functionality already exists (avoid duplication)
- Follow established conventions in similar skills
- Reuse patterns from well-structured skills

✅ **Dual script approach** (Python + Shell):

- Always provide both `.py` and `.sh` versions when possible
- Python for rich features and complex logic
- Shell for lightweight, dependency-free execution
- Document which version to use when

✅ **Clean and minimal**:

- Remove redundant information
- Avoid duplicating documentation between files
- Reference other skills instead of repeating information
- Keep SKILL.md focused and concise

**Examples to follow**:

- `spring-framework-discovery/` - Clean structure, minimal duplication
- `news-aggregator/` - Dual scripts (Python + Shell + PowerShell)
- `github-discovery/` - Well-organized with clear separation

## Skill Categories

### Coding

**Location**: `skills/coding/SKILL.md`

Code implementation following design documents, conventions, and backward compatibility principles.

**Key aspects**:

- Backward compatibility first
- Consistent naming conventions
- Scalable organization
- Logic mapping to design
- Self-verification loops

### Debugging

**Location**: `skills/debugging/SKILL.md`

Step-by-step debugging guide for localizing and fixing bugs based on logs and symptoms.

**Key aspects**:

- Systematic problem isolation
- Root cause analysis
- Fix verification
- Incident documentation

### Design

**Location**: `skills/design/SKILL.md`

Transform investigation findings into comprehensive, standardized design documents.

**Outputs**:

- Architecture impact analysis
- API specifications
- Data model design
- Migration plans

### Framework Discovery

**Location**: `skills/spring-framework-discovery/SKILL.md`

Explore and document framework capabilities (e.g., Spring Framework).

**Example**: Extract all 467+ Spring Framework documentation links systematically.

### Investigation

**Location**: `skills/investigation/SKILL.md`

Comprehensive project investigation with MCP tool integration.

**Sub-skills**:

- `slack-context/` - Gather team discussions and context
- `confluence-discovery/` - Search technical documentation
- `github-analysis/` - Analyze code history

**Workflow**:

1. Find and read RDD
2. Gather related documents
3. Specify requirements
4. Propose solutions
5. Break down into tasks with ManDay estimates

### Planning

Project planning, task breakdown, architecture decisions.

### Review

**Location**: `skills/review/SKILL.md`

Structured code review based on design, standards, and past incidents.

**Checks**:

- Design alignment
- Code quality
- Backward compatibility
- Test coverage
- Security & performance

### Testing

**Location**: `skills/testing/test-case-document/SKILL.md`

Generate comprehensive test cases ensuring complete coverage without blind spots.

**Coverage types**:

- Functional testing
- Integration testing
- Data testing
- System testing

## Quick Reference

| Task               | Command                               |
| ------------------ | ------------------------------------- |
| List all skills    | `ls skills/`                          |
| Create new skill   | Copy `skill-example.md` template      |
| Find by keyword    | `grep -r "keyword" skills/*/SKILL.md` |
| Validate structure | Check SKILL.md < 150 lines            |

## Examples of Good Skills

- **spring-framework-discovery**: Clean structure, scripts in separate files, clear workflow
- **skill-example.md**: Standard template with all required sections

---

**Remember**: Skills should be concise, actionable, and immediately useful. Keep SKILL.md under 150 lines by moving detailed code to separate files.
