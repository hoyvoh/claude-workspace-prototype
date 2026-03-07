---
name: test-case-document-creation
description: "Generate comprehensive test cases from design documents ensuring complete coverage without blind spots"
requires:
  tools: [read_file, write_to_file]
---

# Test Case Document Creation Guide

Systematic approach to identify and document all test cases ensuring comprehensive coverage.

## Prerequisites

- Design document completed (`skills/design/SKILL.md`)
- Access to test case standards
- Understanding of system behavior

## Test Standards Reference

**Common test POV standard**: `docs/test-standards.md`

## Workflow

### Step 1: Analyze Design Document

**Read and understand**:

```
memory/projects/[project-name]/design/design_doc.md
memory/projects/[project-name]/design/api_spec.yaml
memory/projects/[project-name]/design/data_model.sql
```

### Step 2: Identify Test Dimensions

**Apply systematic coverage**:

#### Functional Testing

- Happy path scenarios
- Edge cases
- Error conditions
- Boundary values

#### Integration Testing

- API contract validation
- Database interactions
- External service calls
- Message queue flows

#### Data Testing

- Valid data scenarios
- Invalid data handling
- Data constraints
- Migration validation

### Step 3: Test Case Matrix

**Create comprehensive matrix**:

| Feature    | Scenario          | Input               | Expected        | Priority |
| ---------- | ----------------- | ------------------- | --------------- | -------- |
| User Login | Valid credentials | username, password  | Success + token | P0       |
| User Login | Invalid password  | username, wrong_pwd | 401 Error       | P1       |
| User Login | Non-existent user | fake_user, password | 404 Error       | P1       |
| User Login | Empty credentials | "", ""              | 400 Error       | P2       |

### Step 4: Coverage Verification

**Check for blind spots**:

✅ **All API endpoints covered**
✅ **All database operations tested**
✅ **All error paths validated**
✅ **All business rules verified**
✅ **Migration scenarios included**
✅ **Rollback procedures tested**

### Step 5: Test Case Categories

#### Unit Test Cases

- Individual function behavior
- Isolated component logic
- Mock dependencies

#### Integration Test Cases

- Component interactions
- API end-to-end flows
- Database transactions

#### System Test Cases

- Complete user scenarios
- Performance validation
- Security checks

## Test Case Template

```markdown
## TC-001: [Test Case Name]

**Priority**: P0/P1/P2
**Type**: Functional/Integration/System
**Feature**: [Feature name]

### Preconditions

- User authenticated
- Database in clean state

### Test Steps

1. Step 1 description
2. Step 2 description
3. Step 3 description

### Test Data

- Input 1: value1
- Input 2: value2

### Expected Result

- Output 1: expected_value1
- Status: 200 OK

### Actual Result

- [To be filled during execution]

### Notes

- Special considerations
- Related test cases
```

## Blind Spot Prevention

**Systematic checks**:

1. **Branch Coverage**: Test all code paths
2. **Data Coverage**: Test all data types & constraints
3. **State Coverage**: Test all system states
4. **Error Coverage**: Test all error conditions
5. **Integration Coverage**: Test all connection points

## Output Structure

```
memory/projects/[project-name]/testing/
├── test_plan.md           # Overall test strategy
├── test_cases/
│   ├── functional/        # Functional test cases
│   ├── integration/       # Integration test cases
│   └── system/            # System test cases
└── coverage_matrix.md     # Coverage verification
```

## Quality Checklist

✅ All requirements traced to test cases
✅ All APIs have positive & negative tests
✅ All database operations validated
✅ All error scenarios covered
✅ Performance criteria defined
✅ Security aspects tested

## Quick Reference

| Test Type   | Focus                 | Coverage       |
| ----------- | --------------------- | -------------- |
| Unit        | Function logic        | 80%+ branches  |
| Integration | Component interaction | All APIs       |
| System      | End-to-end flow       | Key scenarios  |
| Regression  | Existing features     | Critical paths |

---

**Next step**: `skills/coding/SKILL.md` for implementation
