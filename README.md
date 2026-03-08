# Claude Workspace Prototype

A collaborative repository for sharing and improving AI agent prompts, skills, and best practices.

## 🎯 Purpose

This workspace serves as a centralized knowledge base for AI agents (like Claude/Cline), containing:

- Reusable skills and prompt templates
- Engineering frameworks and best practices
- Documentation patterns
- Learning from mistakes and improvements over time

## 📋 Table of Contents

- [How to Contribute](#how-to-contribute)
- [Setup](#setup)
- [Usage Guide](#usage-guide)
- [Best Practices](#best-practices)
- [Structure](#structure)
- [Learning & Improvement](#learning--improvement)

## 🤝 How to Contribute

### 1. Clone the Repository

```bash
git clone https://github.com/hoyvoh/claude-workspace-prototype.git
cd claude-workspace-prototype
```

### 2. Create Your Feature Branch

Use the following naming convention:

```bash
git checkout -b feature/<your-username>-<project-name>
```

**Examples:**

- `feature/john-news-aggregator`
- `feature/sarah-api-integration`
- `feature/mike-testing-framework`

### 3. Contribution Guidelines

**DO:**

- ✅ Add new content, skills, and improvements
- ✅ Update directory mappings when adding new sections
- ✅ Update existing skills with improvements and lessons learned
- ✅ Add examples and use cases
- ✅ Document your learnings and mistakes

**DON'T:**

- ❌ Delete existing content
- ❌ Overwrite existing skills (enhance them instead)
- ❌ Remove established patterns and guidelines
- ❌ Break existing directory structure without updating mappings

**EXCEPTIONS:**

- You may update directory maps
- You may update skill mappings and references
- You may refactor for clarity while preserving content

### 4. Submit Your Changes

```bash
git add .
git commit -m "feat: add <description of your contribution>"
git push origin feature/<your-username>-<project-name>
```

Then create a Pull Request for review.

## 🚀 Setup

### Recommended Directory Structure

Clone this repository at the same level as your project repositories:

```
your-workspace/
├── claude-workspace-prototype/     # This repo
├── your-project-1/
├── your-project-2/
└── your-project-3/
```

This allows AI agents to easily reference skills and patterns from this workspace while working on your projects.

### Initial Configuration

1. Clone the repository as shown above
2. Read the `CLAUDE.md` file to understand the framework
3. Explore the `skills/` directory for available capabilities
4. Review examples in `skills/skill-example.md`

## 📖 Usage Guide

### For AI Agents (Claude/Cline)

**Step 1: Read the Framework**

When starting work on a project, instruct your agent to read `CLAUDE.md`:

```
Please read the file CLAUDE.md in the claude-workspace-prototype directory
to understand how to use this workspace and optimize your prompts.
```

**Step 2: Explore Available Skills**

Ask your agent to check available skills:

```
Review the skills/ directory in claude-workspace-prototype
and identify which skills are relevant for this task.
```

**Step 3: Apply and Adapt**

```
Use the patterns from skills/coding/SKILL.md and adapt them
for our specific requirements.
```

### Optimizing Prompts

The workspace contains proven patterns for:

- Code implementation and review
- Testing strategies
- Documentation generation
- API integration
- Git operations
- Debugging approaches

**Example prompt:**

```
Use the debugging skill from claude-workspace-prototype/skills/debugging/SKILL.md
to systematically investigate this issue. Document your findings and any new
debugging patterns we discover in the workspace.
```

## 🎓 Best Practices

### 1. Self-Learning Loop

Instruct your agent to continuously improve the workspace:

```
As you work on this project:
1. Automatically document any reusable patterns you discover
2. Add them to the appropriate skill in claude-workspace-prototype
3. Note any mistakes or anti-patterns to avoid
4. Update the skills with lessons learned
```

### 2. Accumulate Skills Automatically

```
After completing each significant task, please:
1. Extract reusable components and patterns
2. Add them to claude-workspace-prototype/skills/
3. Create or update the relevant SKILL.md file
4. Commit these improvements to the workspace
```

### 3. Learn from Mistakes

```
When encountering errors or better approaches:
1. Document what didn't work and why
2. Add the improved approach to the relevant skill
3. Include examples of common pitfalls to avoid
4. Update the workspace so future agents can benefit
```

### 4. Build on Existing Knowledge

- Always check existing skills before creating new ones
- Enhance rather than replace
- Link related skills together
- Keep documentation up-to-date

## 📁 Structure

```
claude-workspace-prototype/
├── CLAUDE.md                          # Main framework documentation
├── README.md                          # This file
├── LICENSE                            # License information
│
├── skills/                            # Reusable skills and patterns
│   ├── README.md                      # Skills overview
│   ├── skill-example.md               # Template for new skills
│   ├── coding/
│   ├── debugging/
│   ├── design/
│   ├── git-operations/
│   ├── github-discovery/
│   ├── investigation/
│   ├── news-aggregator/
│   ├── review/
│   ├── spring-framework-discovery/
│   └── testing/
│
├── docs/                              # Documentation and guidelines
│   ├── design-docs/
│   ├── overall-architecture/
│   └── review-guidelines/
│
├── claude-engineering-framework/      # Engineering frameworks
│   └── agentic_engineering_framework.md
│
├── memory/                            # Context and memory patterns
│   └── README.md
│
└── templates/                         # Reusable templates
    └── README.md
```

## 🔄 Learning & Improvement

### Continuous Enhancement

This workspace improves through:

1. **Collective Experience**: Each contributor adds their learnings
2. **Mistake Documentation**: What didn't work is as valuable as what did
3. **Pattern Recognition**: Common solutions become reusable skills
4. **Agent Self-Improvement**: Agents learn to optimize their own prompts

### Example Workflow

```bash
# 1. Agent works on your project
# 2. Agent discovers a useful pattern
# 3. Agent automatically updates workspace:

cd claude-workspace-prototype
git checkout -b feature/agent-learning-<topic>

# 4. Agent adds/updates skill documentation
# 5. Agent commits improvements
git add skills/
git commit -m "feat: add pattern for <discovered-pattern>"
git push origin feature/agent-learning-<topic>

# 6. Create PR for team review
```

## 💡 Tips

1. **Start Simple**: Begin with existing skills, then customize
2. **Document Everything**: If you figured it out, document it
3. **Cross-Reference**: Link related skills and docs
4. **Examples Matter**: Include concrete examples in skills
5. **Iterate**: Skills should evolve based on real usage

## 🔗 Key Files to Read

- **`CLAUDE.md`**: The core framework for AI agents
- **`skills/README.md`**: Overview of available skills
- **`skills/skill-example.md`**: Template for creating new skills
- **`docs/README.md`**: Documentation guidelines

## 📝 Creating New Skills

See `skills/skill-example.md` for the template. Each skill should include:

- Clear purpose and use cases
- Prerequisites and dependencies
- Step-by-step instructions
- Examples and code snippets
- Common pitfalls and solutions
- Related skills and resources

## 🤖 Prompt Example for Agents

```
You are working with the claude-workspace-prototype repository.
This is a knowledge base containing:
- Proven patterns and skills
- Engineering best practices
- Lessons learned from previous tasks

Instructions:
1. Read CLAUDE.md to understand the framework
2. Check relevant skills before starting new tasks
3. Apply and adapt existing patterns
4. Document new discoveries and learnings back to the workspace
5. Update skills with improvements (don't delete, enhance)
6. Learn from any mistakes and document solutions

Your goal is both to use this knowledge AND to enrich it for future use.
```

## 📄 License

See [LICENSE](LICENSE) file for details.

## 🌟 Contributing

We welcome contributions! Remember:

- Add, don't delete
- Enhance, don't replace
- Document, don't assume
- Learn, then teach

Together, we build a smarter AI workspace for everyone.
