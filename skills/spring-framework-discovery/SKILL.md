---
name: spring-framework-discovery
description: "Discover and extract all documentation links from Spring Framework documentation website"
requires:
  tools: [execute_command]
  interpreters: [python]
---

# Spring Framework Documentation Discovery

Automate discovery and extraction of all documentation links from Spring Framework's official docs.

**Docs**: [docs.spring.io/spring-framework/reference](https://docs.spring.io/spring-framework/reference/)

## Prerequisites

- Python 3.x installed
- Internet connection
- PowerShell (Windows) or curl (Unix)

## Use Cases

- **Framework Exploration**: Discover all available documentation sections (467+ pages)
- **Learning Path**: Understand complete Spring Framework structure
- **Reference Building**: Create comprehensive index of documentation
- **Update Tracking**: Monitor documentation structure changes across versions

## Quick Start

### Complete Workflow (PowerShell)

```powershell
Invoke-WebRequest -Uri 'https://docs.spring.io/spring-framework/reference/index.html' -UseBasicParsing | Select-Object -ExpandProperty Content | python parse_spring_docs.py
```

### Complete Workflow (Unix)

```bash
curl -s "https://docs.spring.io/spring-framework/reference/index.html" | python parse_spring_docs.py
```

## Scripts

### parse_spring_docs.py

Location: `skills/spring-framework-discovery/parse_spring_docs.py`

**Purpose**: Extract and organize all documentation links from HTML

**Features**:

- Extracts all href links from HTML content
- Filters out external links, assets (CSS, JS, images)
- Cleans and organizes paths
- Outputs sorted list with count

**Usage**:

```bash
# Via pipe
curl -s "https://docs.spring.io/.../index.html" | python parse_spring_docs.py

# Save output
curl -s "https://docs.spring.io/.../index.html" | python parse_spring_docs.py > docs-index.txt
```

## Documentation Structure

Spring Framework docs organized into 7 major categories (467+ pages):

1. **Core Technologies** (~81 pages): IoC Container, AOP, Validation, SpEL
2. **Testing** (~93 pages): MockMvc, WebTestClient, TestContext
3. **Data Access** (~57 pages): JDBC, JPA, Hibernate, Transactions
4. **Web MVC** (~126 pages): Spring MVC, Controllers, Views
5. **Web Reactive** (~60 pages): WebFlux, Reactive Programming, WebClient
6. **Integration** (~30 pages): REST, Email, JMS, Caching, Observability
7. **Languages** (~14 pages): Kotlin, Groovy

## Output Example

```
================================================================================
SPRING FRAMEWORK DOCUMENTATION - ALL DOCUMENT LINKS
================================================================================

Base URL: https://docs.spring.io/spring-framework/reference/
Total unique documentation pages found: 467

--------------------------------------------------------------------------------
DOCUMENTATION LINKS:
--------------------------------------------------------------------------------
  1. appendix.html
  2. core.html
  3. core/aop.html
  4. core/beans.html
  ...
```

## Best Practices

✅ **Always fetch latest**: Documentation changes between versions  
✅ **Filter properly**: Exclude assets and external links  
✅ **Use base URL**: Prepend for complete paths  
✅ **Version awareness**: Check version-specific docs (6.0, 6.1, 6.2, 7.0)

## Anti-Patterns

❌ **Don't hardcode links**: Structure changes  
❌ **Don't skip filtering**: Includes unwanted assets  
❌ **Don't cache indefinitely**: Docs get updated  
❌ **Don't assume static structure**: Major versions differ

## Quick Reference

| Task         | Command                              |
| ------------ | ------------------------------------ |
| Fetch (PS)   | `Invoke-WebRequest -UseBasicParsing` |
| Fetch (Unix) | `curl -s`                            |
| Parse        | `python parse_spring_docs.py`        |
| Full URL     | `base_url + link_path`               |

## Version Support

- Spring Framework 6.0+
- Spring Framework 6.1+
- Spring Framework 6.2+
- Spring Framework 7.0+ (current)

---

**Tip**: Combine with other skills for advanced workflows like automated doc updates, learning path generation, or content analysis.
