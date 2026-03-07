---
name: news-aggregator
description: "Fetch and format world news articles from NewsAPI with professional journalism standards"
requires:
  tools: [execute_command]
  interpreters: [python3]
  api: [newsapi]
---

# News Aggregator Skill

Fetch world news from NewsAPI and format as professional news articles following journalism standards.

## Prerequisites

**Choose one option**:

### Option 1: Python (Recommended for full features)

- Python 3.7+
- `requests` library (`pip install requests`)
- NewsAPI key (get free at https://newsapi.org/register)
- Environment variable: `NEWS_API_KEY`

### Option 2: Shell Script (No Python required)

- **Mac/Linux/Git Bash**: `bash` and `curl`
- **Windows**: PowerShell 5.1+ (built-in)
- NewsAPI key (get free at https://newsapi.org/register)
- Environment variable: `NEWS_API_KEY`

## Quick Start

### Step 1: Setup API Key

```bash
# Set environment variable (Linux/Mac)
export NEWS_API_KEY="your_api_key_here"

# Set environment variable (Windows)
set NEWS_API_KEY=your_api_key_here
```

### Step 2: Fetch News

**Three endpoints available**:

#### Everything (Historical Search)

**Python**:

```bash
python fetch_news.py --endpoint everything -q "artificial intelligence" -n 10
python fetch_news.py --endpoint everything -d "bbc.co.uk,cnn.com" -n 20
python fetch_news.py --endpoint everything -q "climate change" -f 2024-03-01 -t 2024-03-07
```

**Shell (Mac/Linux/Git Bash)**:

```bash
./fetch_news.sh --endpoint everything -q "artificial intelligence" -n 10
./fetch_news.sh --endpoint everything -d "bbc.co.uk,cnn.com" -n 20
```

**PowerShell (Windows)**:

```powershell
.\fetch_news.ps1 -Endpoint everything -Query "artificial intelligence" -PageSize 10
.\fetch_news.ps1 -Endpoint everything -Domains "bbc.co.uk,cnn.com" -PageSize 20
```

#### Top Headlines (Breaking News)

**Python**:

```bash
python fetch_news.py --endpoint headlines -c us --category technology -n 20
python fetch_news.py --endpoint headlines -c vn -n 15
```

**Shell (Mac/Linux/Git Bash)**:

```bash
./fetch_news.sh --endpoint headlines -c us --category technology -n 20
./fetch_news.sh --endpoint headlines -c vn -n 15
```

**PowerShell (Windows)**:

```powershell
.\fetch_news.ps1 -Endpoint headlines -Country us -Category technology -PageSize 20
.\fetch_news.ps1 -Endpoint headlines -Country vn -PageSize 15
```

#### Sources (Discovery)

**Python**:

```bash
python fetch_news.py --endpoint sources -c vn -o vn_sources.md
```

**Shell (Mac/Linux/Git Bash)**:

```bash
./fetch_news.sh --endpoint sources -c vn -o vn_sources.md
```

**PowerShell (Windows)**:

```powershell
.\fetch_news.ps1 -Endpoint sources -Country vn -Output vn_sources.md
```

### Step 3: Review Output

Generated markdown file: `news_report.md`

## API Reference

**Schema**: `api_schema.md`

**Complete NewsAPI documentation with**:

- Endpoint details
- Request parameters
- Response schema
- Error codes
- Rate limits

## Script: fetch_news.py

**Location**: `skills/news-aggregator/fetch_news.py`

**Functions**:

- `fetch_news()` - Call NewsAPI
- `format_article_markdown()` - Format single article
- `format_news_report()` - Format complete report
- `save_markdown()` - Save to file

**Features**:

- Automatic date formatting
- Image embedding
- Source attribution
- Clean markdown output

## Article Format Guide

**Reference**: `news_article_format_guide.md`

**Based on**: Grammarly's professional journalism standards

**Key components**:

1. **Headline** - Compelling, factual, active voice
2. **Byline** - Author, date, source
3. **Lead (Lede)** - Answer 5 W's + H
4. **Body** - Inverted pyramid structure
5. **Quotes** - Properly attributed
6. **Sources** - Cited and linked

## Use Cases

### Everything Endpoint

**Daily News Digest**:

```bash
python fetch_news.py --endpoint everything -q "technology OR AI" \
  -f $(date -d "yesterday" +%Y-%m-%d) \
  --sort publishedAt -n 20 -o daily_tech_digest.md
```

**Topic Research**:

```bash
python fetch_news.py --endpoint everything -q "quantum computing" \
  -f 2024-01-01 --sort relevancy -n 50 -o quantum_research.md
```

**Vietnamese News**:

```bash
python fetch_news.py --endpoint everything -q "kinh tế" \
  -l vi --sort publishedAt -n 15 -o tin_kinh_te.md
```

### Headlines Endpoint

**Breaking US Tech News**:

```bash
python fetch_news.py --endpoint headlines -c us --category technology \
  -n 20 -o us_tech_headlines.md
```

**Vietnam Today**:

```bash
python fetch_news.py --endpoint headlines -c vn \
  -n 30 -o vietnam_today.md
```

**Global Business Headlines**:

```bash
python fetch_news.py --endpoint headlines \
  -s "bloomberg,financial-times,reuters" -n 25 -o business_headlines.md
```

### Sources Endpoint

**Discover Tech Sources**:

```bash
python fetch_news.py --endpoint sources --category technology \
  -l en -o tech_sources.md
```

**Vietnamese Media Directory**:

```bash
python fetch_news.py --endpoint sources -c vn -o vn_sources.md
```

### Advanced Workflows

**JSON Export for Analysis**:

```bash
python fetch_news.py --endpoint everything -q "blockchain" \
  -n 100 --json -o blockchain_data.json
```

**Multi-Source Comparison**:

```bash
# Fetch from BBC
python fetch_news.py --endpoint headlines -s "bbc-news" -n 10 -o bbc.md

# Fetch from CNN
python fetch_news.py --endpoint headlines -s "cnn" -n 10 -o cnn.md
```

## Output Format

### Markdown Report Structure

```markdown
# News Report

**Search Query**: artificial intelligence
**Total Results**: 12,543
**Articles Shown**: 20
**Generated**: March 7, 2024 at 11:30 AM

---

## 1. [Article Title]

**Source**: TechCrunch
**Author**: John Doe
**Published**: March 7, 2024 at 09:15 AM UTC
**URL**: [link]

![Article Image](image-url)

### Summary

[Article description]

### Content Preview

[Article content excerpt]

---

[More articles...]

---

_Powered by NewsAPI_
```

## Best Practices

✅ **API Usage**:

- Cache responses to reduce API calls
- Use specific queries for relevant results
- Respect rate limits (100/day on free tier)
- Handle errors gracefully

✅ **Writing Quality**:

- Follow inverted pyramid structure
- Cite all sources with links
- Maintain objectivity
- Verify facts across sources

✅ **Markdown Formatting**:

- Use clear headings hierarchy
- Include images with alt text
- Format dates consistently
- Add proper line breaks

## Error Handling

| Error                  | Cause                  | Solution                 |
| ---------------------- | ---------------------- | ------------------------ |
| `NEWS_API_KEY not set` | Missing env variable   | Set `NEWS_API_KEY`       |
| `apiKeyInvalid`        | Wrong API key          | Check key at newsapi.org |
| `rateLimited`          | Exceeded requests      | Wait or upgrade plan     |
| `parametersMissing`    | No query/source/domain | Add required parameter   |

## Rate Limits

**Free tier**: 100 requests/day

**Strategy for high usage**:

```python
# Fetch once, save JSON
python fetch_news.py -q "topic" --json -o cache.json

# Process cached data multiple times
# without API calls
```

## Script Comparison

| Feature                 | Python              | Bash/Shell               | PowerShell          |
| ----------------------- | ------------------- | ------------------------ | ------------------- |
| **Platform**            | Cross-platform      | Mac/Linux/Git Bash       | Windows native      |
| **Prerequisites**       | Python + requests   | bash + curl              | Built-in (5.1+)     |
| **Markdown Formatting** | Full (professional) | Basic (simplified)       | Full (professional) |
| **JSON Parsing**        | Native              | grep/sed only            | Native              |
| **Error Handling**      | Comprehensive       | Basic                    | Comprehensive       |
| **Date Formatting**     | Full control        | Basic                    | Full control        |
| **Best For**            | Full features       | Quick queries, no Python | Native Windows use  |

**Recommendation**: Use Python for production, shell scripts for quick queries or when Python is unavailable.

## Quick Reference

### Endpoints

| Endpoint     | Purpose          | Best For                   |
| ------------ | ---------------- | -------------------------- |
| `everything` | Search all news  | Research, historical data  |
| `headlines`  | Breaking news    | Current events, by country |
| `sources`    | Source discovery | Find news sources          |

### Common Parameters

| Parameter    | Endpoints             | Example                        |
| ------------ | --------------------- | ------------------------------ |
| `--endpoint` | All                   | `everything/headlines/sources` |
| `-q`         | everything, headlines | `-q "AI"`                      |
| `-s`         | everything, headlines | `-s "bbc-news,cnn"`            |
| `-c`         | headlines, sources    | `-c us`                        |
| `--category` | headlines, sources    | `--category technology`        |
| `-d`         | everything            | `-d "bbc.co.uk"`               |
| `-f`         | everything            | `-f 2024-01-01`                |
| `-t`         | everything            | `-t 2024-03-07`                |
| `-l`         | everything, sources   | `-l en/vi/es`                  |
| `--sort`     | everything            | `--sort publishedAt`           |
| `-n`         | everything, headlines | `-n 20`                        |
| `-o`         | All                   | `-o output.md`                 |
| `--json`     | All                   | `--json`                       |

### Quick Commands

**Everything**:

```bash
python fetch_news.py --endpoint everything -q "keyword" -n 20
```

**Headlines**:

```bash
python fetch_news.py --endpoint headlines -c us --category tech -n 20
```

**Sources**:

```bash
python fetch_news.py --endpoint sources --category technology -l en
```

---

**API Documentation**: https://newsapi.org/docs  
**Format Guide**: `news_article_format_guide.md`  
**Script**: `fetch_news.py`  
**API Schema**: `api_schema.md`
