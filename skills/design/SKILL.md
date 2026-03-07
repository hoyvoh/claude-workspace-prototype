---
name: design-document-creation
description: "Create comprehensive design documents from investigation findings and technical sources"
requires:
  tools: [read_file, write_to_file]
---

# Design Document Creation Guide

Transform investigation findings into comprehensive, standardized design documents.

## Prerequisites

- Investigation completed (`skills/investigation/SKILL.md`)
- RDD document available in memory
- Related documents gathered
- Technical requirements clear

## Design Document Template

**Location**: `templates/design_doc_template.md`

## Workflow

### Step 1: Read Investigation Documents

```bash
# Load project investigation
memory/projects/[project-name]/investigation.md
memory/projects/[project-name]/rdd.md
memory/projects/[project-name]/related-docs/
```

### Step 2: Additional Source Research

**Consult**:

- Framework official documentation
- Architecture patterns
- Best practices guides
- Similar implementations

### Step 3: Create Design Document

**Output structure** (use template):

#### 1. Overview

- Feature description
- Business goals
- Scope boundaries

#### 2. Architecture Impact

- System components affected
- Integration points
- Dependency changes
- Performance implications

#### 3. API Changes

- New endpoints
- Modified endpoints
- Deprecated APIs
- Request/Response schemas

#### 4. Data Model

- Database schema changes
- New tables/collections
- Modified fields
- Indexes required
- Data relationships

#### 5. Migration Plan

- Database migrations
- Data transformation steps
- Rollback strategy
- Backward compatibility approach

### Step 4: Review Checklist

✅ **Architecture**:

- All components identified
- Dependencies mapped
- Scalability considered

✅ **API Design**:

- RESTful/consistent
- Versioning strategy
- Error handling defined

✅ **Data Model**:

- Normalized/appropriate
- Indexes optimized
- Migration safe

✅ **Non-functional**:

- Security considered
- Performance estimated
- Monitoring planned

## Output Files

```
memory/projects/[project-name]/
├── design/
│   ├── design_doc.md        # Main design document
│   ├── api_spec.yaml        # API specification
│   ├── data_model.sql       # Schema DDL
│   └── migration_plan.md    # Migration steps
```

## Quality Standards

**Design must include**:

- Clear architecture diagrams
- API contract specifications
- Complete data model
- Step-by-step migration plan
- Security considerations
- Performance estimates

## Quick Reference

| Section      | Content             | Source             |
| ------------ | ------------------- | ------------------ |
| Overview     | Goals & scope       | RDD                |
| Architecture | Components & flow   | Investigation      |
| API          | Contracts & schemas | Requirements       |
| Data Model   | Schema & relations  | Technical analysis |
| Migration    | Steps & rollback    | Best practices     |

---

**Reference template**: `templates/design_doc_template.md`  
**After design**: Proceed to `skills/testing/test-case-document/SKILL.md`
