# Agentic Engineering Framework

**Prompt Chaining Skills for Claude Engineering**

A systematic framework for AI-assisted software engineering with structured workflows, reusable skills, and persistent memory.

---

## Part 1: The Problem

### Engineering Knowledge Fragmented

**Current challenges**:

- Documentation scattered across wikis, Slack, emails, code comments
- Tribal knowledge locked in individuals' minds
- No central source of architectural decisions
- Framework knowledge dispersed and hard to discover
- Past incidents and lessons not systematically captured

### Guidelines Inconsistent

**Inconsistency issues**:

- Different teams follow different coding standards
- Review criteria varies by reviewer
- Design patterns applied inconsistently
- Testing approaches differ between projects
- No standardized workflow across teams

### LLM Usage Chaotic

**Ad-hoc LLM interaction**:

- One-off prompts without structure
- No reusable patterns or workflows
- Context lost between conversations
- No knowledge persistence across sessions
- Difficult to reproduce quality results
- Each developer invents their own approach

**The Result**: Wasted time, inconsistent quality, knowledge loss, repeated mistakes.

---

## Part 2: The Solution

### Skills: Reusable Workflows

**What are Skills?**

- Self-contained, documented workflows
- Step-by-step instructions for common tasks
- Include prerequisites, examples, best practices
- Each skill < 150 lines for quick reference
- External scripts for complex logic

**Examples**:

- `investigation/` - Project investigation with RDD discovery
- `design/` - Design document creation
- `coding/` - Implementation with backward compatibility
- `review/` - Structured code review
- `testing/` - Comprehensive test case generation
- `debugging/` - Systematic bug localization

### Project Memory: Persistent Context

**Memory Structure**:

```
memory/
├── claude_memory.md          # Global learnings
├── incidents.md              # Past incidents database
└── projects/
    └── [project-name]/
        ├── rdd.md                # Requirements
        ├── investigation.md      # Findings
        ├── design/               # Design docs
        ├── testing/              # Test cases
        ├── coding/               # Implementation notes
        ├── review/               # Code reviews
        ├── bugs/                 # Bug tracking
        └── slack-context/        # Team discussions
```

**Benefits**:

- Context persists across conversations
- Historical decisions preserved
- Lessons learned accumulated
- Patterns recognized and reused

### Source of Truth: No Duplication

**Principle**: Always reference, never duplicate.

**Implementation**:

- Link to official framework documentation (e.g., `docs.spring.io`)
- Reference internal design docs by path
- Point to Confluence pages
- Cite Slack threads
- Index and search rather than copy

**Result**: Single source of truth, always current, no sync issues.

### Workflow Orchestration: Chained Skills

**Sequential execution**:

```
Investigation → Design → Test Planning → Coding → Review → Debugging
```

**Each skill**:

- Reads outputs from previous skill
- Produces structured artifacts
- Passes context to next skill
- Updates project memory

**Example flow**:

1. Investigation saves RDD to `memory/projects/[name]/rdd.md`
2. Design reads RDD, creates design doc
3. Test Planning reads design, generates test cases
4. Coding reads design + tests, implements features
5. Review reads design + code, validates quality
6. Debugging reads incidents + logs, fixes issues

---

## Part 3: Architecture

### Skills Layer

**Purpose**: Encapsulate engineering workflows

**Components**:

- Skill documents (SKILL.md)
- Supporting scripts (Python, Shell)
- Templates (design doc, test case)
- Example outputs

**Organization**:

```
skills/
├── investigation/
│   ├── SKILL.md
│   └── slack-context/
├── design/
├── testing/
├── coding/
├── review/
└── debugging/
```

### Memory Layer

**Purpose**: Persist knowledge across sessions

**Components**:

- Project-specific memory
- Global insights (claude_memory.md)
- Incident database (incidents.md)
- Team context (Slack summaries)

**Access patterns**:

- Read: Load context at skill start
- Write: Update after completing tasks
- Search: Find relevant past decisions
- Aggregate: Learn patterns over time

### Runtime Layer

**Purpose**: Execute skills with tool access

**Components**:

- MCP servers (Slack, Confluence, GitHub)
- CLI tools (git, gh, npm, pytest)
- File operations (read, write, search)
- Documentation indexing

**Capabilities**:

- Access external systems
- Read/write project files
- Execute commands
- Search codebases

### UI Layer

**Purpose**: Human-AI interaction

**Components**:

- Chat interface (Claude in IDE)
- File explorer integration
- Diff/review views
- Terminal output

**Features**:

- Conversational planning
- Approval workflows
- Progress tracking
- Result presentation

---

## Part 4: Team Workflow

### Investigation Phase

**Goal**: Understand requirements and context

**Activities**:

1. Find and read project RDD
2. Gather from Slack, Confluence, GitHub
3. Analyze tech stack and architecture
4. Specify requirements clearly
5. Propose solution approach
6. Break into tasks with estimates

**Outputs**:

- `investigation.md`
- `rdd.md`
- Task list with ManDay estimates

**Skill**: `skills/investigation/SKILL.md`

### Design Phase

**Goal**: Create comprehensive design

**Activities**:

1. Read investigation findings
2. Research best practices
3. Design architecture
4. Specify APIs
5. Model data structures
6. Plan migration

**Outputs**:

- `design/design_doc.md`
- `design/api_spec.yaml`
- `design/data_model.sql`
- `design/migration_plan.md`

**Skill**: `skills/design/SKILL.md`

### Coding Phase

**Goal**: Implement per design

**Activities**:

1. Read design document
2. Follow coding conventions
3. Maintain backward compatibility
4. Use consistent naming
5. Implement with tests
6. Self-review

**Outputs**:

- Implementation code
- `coding/implementation_log.md`
- `coding/self_review.md`

**Skill**: `skills/coding/SKILL.md`

### Testing Phase

**Goal**: Ensure comprehensive coverage

**Activities**:

1. Analyze design document
2. Identify test dimensions
3. Create test matrix
4. Write test cases
5. Verify coverage
6. Execute tests

**Outputs**:

- `testing/test_plan.md`
- `testing/test_cases/`
- `testing/coverage_matrix.md`
- Test results

**Skill**: `skills/testing/test-case-document/SKILL.md`

### Review Phase

**Goal**: Validate quality

**Activities**:

1. Verify design alignment
2. Check coding standards
3. Validate compatibility
4. Review test coverage
5. Check security
6. Cross-reference incidents

**Outputs**:

- `review/review_report.md`
- `review/issues.md`
- `review/approval.md`

**Skill**: `skills/review/SKILL.md`

### Deploy Phase

**Goal**: Safely release to production

**Activities**:

1. Review deployment plan
2. Execute pre-deployment checks
3. Run smoke tests
4. Monitor metrics
5. Verify functionality
6. Document deployment

**Integration**: Standard deployment workflows

---

## Part 5: Example - Feature Request Flow

### Scenario: Add User Authentication Feature

#### Step 1: Investigation

**Input**: "Add OAuth2 authentication to payment service"

**AI Actions**:

1. Search Confluence for "payment service architecture"
2. Check Slack #payment-team for recent discussions
3. Review GitHub history for similar changes
4. Load `memory/projects/payment-service/rdd.md`

**Output**: `investigation.md`

```markdown
## Requirements

- OAuth2 with JWT tokens
- Support Google, GitHub providers
- Backward compatible with existing API keys

## Architecture Context

- Spring Boot microservice
- PostgreSQL database
- Redis for session storage

## Task Breakdown

1. Design document - 1 ManDay
2. Test cases - 0.5 ManDay
3. Implementation - 3 ManDays
4. Code review - 0.5 ManDay
5. Testing - 1 ManDay
   Total: 6 ManDays
```

#### Step 2: Design

**Input**: Investigation findings

**AI Actions**:

1. Read Spring Security OAuth2 docs (source of truth)
2. Design authentication flow
3. Specify API endpoints
4. Model database schema
5. Plan migration strategy

**Output**: `design/design_doc.md`

```markdown
## Architecture

- Spring Security OAuth2 Resource Server
- JWT token validation
- User role mapping

## API Changes

- POST /auth/login (new)
- POST /auth/refresh (new)
- All existing endpoints accept JWT

## Data Model

- users table (id, email, provider, created_at)
- oauth_tokens table (token_hash, user_id, expires_at)

## Migration

- Phase 1: Add OAuth alongside API keys
- Phase 2: Migrate users gradually
- Phase 3: Deprecate API keys (6 months)
```

#### Step 3: Test Planning

**Input**: Design document

**AI Actions**:

1. Analyze authentication flows
2. Identify edge cases
3. Create test matrix
4. Ensure blind spot coverage

**Output**: `testing/test_cases/functional/auth.md`

```markdown
## TC-001: Successful OAuth Login

- Input: Valid Google token
- Expected: JWT + user record

## TC-002: Invalid Token

- Input: Expired/malformed token
- Expected: 401 Unauthorized

## TC-003: Backward Compatibility

- Input: Legacy API key
- Expected: Still works
```

#### Step 4: Coding

**Input**: Design + test cases

**AI Actions**:

1. Implement OAuth2 configuration
2. Create authentication endpoints
3. Add database migrations
4. Write unit tests
5. Ensure backward compatibility

**Output**: Code implementation

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    // Implementation following design doc
    // Backward compatible with API keys
}
```

#### Step 5: Review

**Input**: Code changes

**AI Actions**:

1. Check design alignment ✅
2. Verify naming conventions ✅
3. Validate test coverage ✅
4. Check security best practices ✅
5. Confirm backward compatibility ✅

**Output**: `review/review_report.md`

```markdown
## ✅ Approved

### Strengths

- Clean implementation per design
- 95% test coverage
- Backward compatible

### Minor Issues

- Add rate limiting to login endpoint
- Improve error messages
```

### Result

**Complete feature delivered**:

- Investigated: Requirements clear
- Designed: Architecture documented
- Tested: Comprehensive coverage
- Coded: Quality implementation
- Reviewed: Standards validated
- **Ready for deployment**

**Knowledge preserved**:

- `memory/projects/payment-service/` contains all artifacts
- `memory/incidents.md` updated with OAuth patterns
- `memory/claude_memory.md` updated with Spring Security learnings

**Reusable for future**:

- Next OAuth implementation can reference this
- Design patterns captured
- Test cases serve as template
- Code review checklist refined

---

## Summary

### Framework Benefits

**For Teams**:

- ✅ Consistent workflows
- ✅ Knowledge preservation
- ✅ Quality assurance
- ✅ Faster onboarding
- ✅ Reduced errors

**For AI**:

- ✅ Structured approach
- ✅ Context persistence
- ✅ Reusable patterns
- ✅ Continuous learning
- ✅ Reproducible results

**For Projects**:

- ✅ Complete documentation
- ✅ Traceable decisions
- ✅ Historical context
- ✅ Systematic improvement
- ✅ Predictable delivery

### Getting Started

1. **Clone framework**: `git clone [repo]`
2. **Explore skills**: Read `skills/README.md`
3. **Try example**: Follow investigation → design → coding
4. **Adapt to team**: Customize skills and templates
5. **Build memory**: Accumulate project knowledge
6. **Scale usage**: Apply across all projects

---

**Framework Repository**: `claude-workspace-prototype`  
**Documentation**: See `CLAUDE.md` for complete guide  
**Skills**: See `skills/` for all available workflows
