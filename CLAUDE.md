# Claude Workspace Guide

AI agent workspace for structured software engineering workflows with reusable skills, templates, and persistent memory.

## Quick Start

1. **Explore repository structure** to understand available capabilities
2. **Load skills** from `skills/` directory for common workflows
3. **Use templates** from `templates/` for consistent outputs
4. **Update memory** in `memory/` when discovering insights
5. **Always reference source of truth** when answering user questions

## Workspace Structure

```
claude-workspace-prototype/
├── skills/              # Reusable AI agent skills
├── templates/           # Engineering document templates
├── memory/              # Persistent knowledge base
├── docs/                # Framework documentation
├── index-mcp/           # Documentation indexing tools
└── examples/            # Example workflows
```

## Skills System

**Location**: `skills/`

Self-contained, documented workflows for common engineering tasks. See `skills/README.md` for complete guide.

### Available Skills

| Category                      | Purpose                               |
| ----------------------------- | ------------------------------------- |
| `coding/`                     | Code generation, refactoring          |
| `debugging/`                  | Error investigation, troubleshooting  |
| `design/`                     | Architecture patterns, system design  |
| `framework-discovery-guide/`  | Framework documentation exploration   |
| `investigation/`              | Code analysis, dependency exploration |
| `planning/`                   | Project planning, task breakdown      |
| `review/`                     | Code review, quality validation       |
| `spring-framework-discovery/` | Spring Framework docs extraction      |
| `testing/`                    | Test strategy, test generation        |

### Skill Structure

Each skill contains:

- `SKILL.md` - Main documentation (<150 lines, REQUIRED)
- Supporting scripts (Python, Shell, etc.)
- Example outputs

### Using Skills

1. Browse `skills/` directory
2. Read `SKILL.md` for workflow
3. Follow Quick Start section
4. Reference included scripts
5. Adapt to your use case

**Important Rules**:

- SKILL.md must be under 150 lines
- Move code to external files (reference location in SKILL.md)
- Include YAML frontmatter with name, description, requires
- Provide concrete, runnable examples

See `skills/README.md` and `skills/skill-example.md` for details.

## Templates

**Location**: `templates/`

Standardized formats for engineering artifacts:

- `design_doc_template.md` - System design documentation
- `test_plan_template.md` - Test planning and coverage
- `bug_report_template.md` - Bug reporting and tracking

Use templates to ensure consistent, structured outputs.

## Persistent Memory

**Location**: `memory/claude_memory.md`

Accumulate engineering knowledge over time:

- Architectural patterns
- Coding standards
- Lessons learned
- Common pitfalls
- Best practices

Update memory when discovering meaningful insights.

## Documentation

**Location**: `docs/`

Framework documentation and guidelines:

- `framework_overview.md` - Framework concepts
- `team_adoption.md` - Onboarding guide

## Indexing System

**Location**: `index-mcp/`

Tools for building searchable knowledge bases:

- Framework documentation
- Design documents
- Architecture docs
- Engineering knowledge

Enables semantic retrieval for investigation workflows.

## Standard Engineering Workflow

**Complete development lifecycle**:

1. **Investigation** (`skills/investigation/SKILL.md`)
   - Find and read project RDD
   - Gather related documents (Slack, Confluence, GitHub)
   - Specify requirements and present to developer
   - Propose solution based on tech stack
   - Break down into tasks with ManDay estimates

2. **Design** (`skills/design/SKILL.md`)
   - Create comprehensive design document
   - Define architecture impact
   - Specify API changes
   - Design data model
   - Plan migration strategy

3. **Test Planning** (`skills/testing/test-case-document/SKILL.md`)
   - Analyze design document
   - Identify all test dimensions (functional, integration, data)
   - Create test case matrix
   - Ensure no blind spots
   - Document test cases

4. **Implementation** (`skills/coding/SKILL.md`)
   - Follow design document
   - Maintain backward compatibility
   - Use consistent naming conventions
   - Ensure scalable organization
   - Perform self-verification

5. **Code Review** (`skills/review/SKILL.md`)
   - Verify design alignment
   - Check code quality and standards
   - Ensure backward compatibility
   - Validate test coverage
   - Cross-reference with past incidents

6. **Debugging** (`skills/debugging/SKILL.md`)
   - Gather information and reproduce bugs
   - Isolate problems systematically
   - Analyze root cause
   - Fix and verify
   - Document findings

## Core Principles

### 1. Source of Truth First - Don't Duplicate

**Always refer to original sources instead of copying content.**

- ✅ Link to official documentation (e.g., `https://docs.spring.io/...`)
- ✅ Reference file paths in repository (e.g., `skills/README.md`)
- ✅ Point to authoritative sources
- ❌ Don't copy/paste documentation into local files
- ❌ Don't duplicate content that exists elsewhere
- ❌ Don't recreate what already exists at a public URL

**Examples**:

- Instead of copying Spring docs → Link to `docs.spring.io`
- Instead of duplicating skill docs → Reference `skills/[name]/SKILL.md`
- Instead of copying code → Reference file location

**When Answering User Questions**:

- ✅ Always cite official documentation links
- ✅ Reference relevant sections in official docs
- ✅ Provide links to authoritative sources
- ✅ Guide users to original documentation for deep learning
- ❌ Don't provide answers without referencing sources
- ❌ Don't duplicate documentation content in responses

Prioritize authoritative sources: official docs, design documents, architecture descriptions.

### 2. Skills Over Ad-hoc Prompting

Use reusable skills instead of improvising. Skills encapsulate best practices and structured workflows.

### 3. Scoped Retrieval

Search only relevant indexes. Avoid excessive context. Prioritize high-confidence sources.

### 4. Inspectable Planning

For complex tasks: produce clear plan, break into steps, allow human inspection.

### 5. Modular Context

Inject context as structured components: architecture summaries, design docs, coding guidelines.

### 6. Bounded Autonomy

Respect operational boundaries:

- Confirm before modifying critical files
- Don't auto-push code
- Avoid destructive actions without approval

### 7. Reviewable Outputs

Produce reviewable artifacts: design docs, code patches, test plans, bug reports. Follow templates.

### 8. Observability

Keep reasoning traceable:

- Explain decisions
- Reference sources
- Record significant actions

### 9. Workflow Quality

Evaluate process, not just results:

- Planning completeness
- Design correctness
- Test coverage adequacy

### 10. Continuous Learning

Accumulate knowledge in `memory/claude_memory.md`:

- Framework quirks
- Debugging patterns
- Best practices

## Initialization Checklist

When entering this workspace:

1. ✅ Explore repository structure
2. ✅ Discover available skills
3. ✅ Load engineering templates
4. ✅ Read framework documentation
5. ✅ Load persistent memory
6. ✅ Identify indexing capabilities

## Project Initialization Workflow

**When starting a new project**, Claude can self-organize by:

### Step 1: Access Historical Context

**Load previous project memories**:

```
memory/projects/[old-project-1]/
memory/projects/[old-project-2]/
memory/claude_memory.md
memory/incidents.md
```

### Step 2: Analyze Project Type

**Identify characteristics**:

- Technology stack (Spring, React, Python, etc.)
- Project scale (microservice, monolith, library)
- Domain (e-commerce, fintech, analytics)
- Team structure

### Step 3: Setup Project Environment

**Create project structure**:

```
memory/projects/[new-project-name]/
├── rdd.md                  # Requirements document
├── investigation.md        # Investigation findings
├── design/                 # Design documents
├── testing/                # Test cases
├── coding/                 # Implementation notes
├── review/                 # Code reviews
├── bugs/                   # Bug tracking
└── slack-context/          # Team discussions
```

### Step 4: Load Relevant Skills

**Based on project type, prepare**:

- Investigation skills (Slack, Confluence, GitHub access)
- Framework-specific skills (Spring, React, etc.)
- Domain-specific patterns
- Testing strategies

### Step 5: Establish Context

**Gather and organize**:

1. Read RDD and requirements
2. Collect Slack context (last 30 days)
3. Review similar past projects
4. Load relevant incidents and lessons
5. Identify team conventions

### Step 6: Ready State

**Confirm setup**:

- ✅ Project memory structure created
- ✅ Relevant skills identified
- ✅ Historical context loaded
- ✅ Team conventions understood
- ✅ Ready to begin investigation workflow

**Example initialization**:

```bash
# Claude auto-initialization for new Spring Boot project
1. Detected: Spring Boot microservice
2. Loaded: skills/spring-framework-discovery/
3. Created: memory/projects/payment-service/
4. Retrieved: Past Spring projects patterns
5. Gathered: Slack context from #payment-team
6. Ready: Begin investigation workflow
```

## Contributing

### Adding New Skills

1. Create directory: `skills/your-skill-name/`
2. Add SKILL.md (< 150 lines)
3. Add supporting scripts
4. Test all examples
5. Update `skills/README.md` if needed

### Updating Framework

Suggest improvements to:

- Skills
- Templates
- Documentation
- Memory

Keep updates consistent with core principles.

## Goals

Transform engineering knowledge into:

- ✨ Reusable skills
- 📋 Structured workflows
- 🔍 Searchable knowledge
- 🎯 Continuously improving intelligence

---

**For detailed skill creation guide**: See `skills/README.md`  
**For skill template**: See `skills/skill-example.md`  
**For Spring Framework discovery example**: See `skills/spring-framework-discovery/`
