# NewsAPI Schema Documentation

**Base URL**: `https://newsapi.org/v2`

**Authentication**: API Key required in header or query parameter

---

## Endpoints Overview

| Endpoint         | Purpose                 | Use Case                                  |
| ---------------- | ----------------------- | ----------------------------------------- |
| `/everything`    | Search all articles     | Research, historical data, keyword search |
| `/top-headlines` | Breaking news headlines | Current top stories, category browsing    |
| `/sources`       | Available news sources  | Source discovery, metadata                |

---

## Endpoint 1: Everything

**URL**: `/everything`

**Method**: `GET`

**Description**: Search through millions of articles from over 150,000 sources, large and small.

### Authentication

**Header**:

```
X-Api-Key: YOUR_API_KEY
```

**OR Query Parameter**:

```
apiKey=YOUR_API_KEY
```

### Request Parameters

| Parameter        | Type             | Required   | Description                                                       |
| ---------------- | ---------------- | ---------- | ----------------------------------------------------------------- |
| `q`              | string           | Optional\* | Keywords or phrases to search for in article title and body       |
| `searchIn`       | string           | Optional   | Fields to restrict search to: `title`, `description`, `content`   |
| `sources`        | string           | Optional   | Comma-separated string of news source IDs                         |
| `domains`        | string           | Optional   | Comma-separated string of domains to restrict search              |
| `excludeDomains` | string           | Optional   | Comma-separated string of domains to exclude                      |
| `from`           | string(ISO 8601) | Optional   | Oldest article date (e.g., `2024-01-01` or `2024-01-01T12:00:00`) |
| `to`             | string(ISO 8601) | Optional   | Newest article date                                               |
| `language`       | string           | Optional   | 2-letter ISO-639-1 code (e.g., `en`, `es`, `fr`, `vi`)            |
| `sortBy`         | string           | Optional   | `relevancy` (default), `popularity`, `publishedAt`                |
| `pageSize`       | int              | Optional   | Number of results per page (max 100)                              |
| `page`           | int              | Optional   | Page number (default 1)                                           |

\*At least one of: `q`, `sources`, `domains` is required

### Supported Languages

`ar`, `de`, `en`, `es`, `fr`, `he`, `it`, `nl`, `no`, `pt`, `ru`, `sv`, `ud`, `zh`

### Response Schema

```json
{
  "status": "ok",
  "totalResults": 12345,
  "articles": [
    {
      "source": {
        "id": "source-id",
        "name": "Source Name"
      },
      "author": "Author Name",
      "title": "Article Title",
      "description": "Article description",
      "url": "https://article-url.com",
      "urlToImage": "https://image-url.com/image.jpg",
      "publishedAt": "2024-03-07T10:00:00Z",
      "content": "Article content preview [+1234 chars]"
    }
  ]
}
```

### Error Response

```json
{
  "status": "error",
  "code": "parameterInvalid",
  "message": "Detailed error message"
}
```

### Common Error Codes

| Code                 | Description                         |
| -------------------- | ----------------------------------- |
| `apiKeyDisabled`     | API key disabled                    |
| `apiKeyExhausted`    | API key rate limit exceeded         |
| `apiKeyInvalid`      | API key invalid                     |
| `apiKeyMissing`      | API key missing                     |
| `parameterInvalid`   | Invalid parameter value             |
| `parametersMissing`  | Required parameters missing         |
| `rateLimited`        | Rate limit exceeded                 |
| `sourcesTooMany`     | Too many sources specified (max 20) |
| `sourceDoesNotExist` | Specified source does not exist     |

---

## Example Requests

### Search by Keyword

```bash
GET /everything?q=bitcoin&sortBy=publishedAt&apiKey=YOUR_API_KEY
```

### Search with Date Range

```bash
GET /everything?q=climate&from=2024-01-01&to=2024-03-07&language=en&sortBy=relevancy&apiKey=YOUR_API_KEY
```

### Search by Domain

```bash
GET /everything?domains=bbc.co.uk,cnn.com&sortBy=publishedAt&apiKey=YOUR_API_KEY
```

### Search in Vietnamese

```bash
GET /everything?q=công nghệ&language=vi&sortBy=publishedAt&apiKey=YOUR_API_KEY
```

---

## Rate Limits

**Developer Plan**:

- 100 requests per day
- 1 month of historical data

**Business Plans**: Higher limits, contact NewsAPI

---

## Best Practices

1. **Cache responses** to reduce API calls
2. **Use specific queries** to get relevant results
3. **Paginate results** for large datasets
4. **Handle errors gracefully** with fallback strategies
5. **Respect rate limits** to avoid API key suspension

---

## Endpoint 2: Top Headlines

**URL**: `/top-headlines`

**Method**: `GET`

**Description**: Breaking news headlines and top stories from news sources and blogs across the web.

### Authentication

**Header**:

```
X-Api-Key: YOUR_API_KEY
```

**OR Query Parameter**:

```
apiKey=YOUR_API_KEY
```

### Request Parameters

| Parameter  | Type   | Required   | Description                                                                         |
| ---------- | ------ | ---------- | ----------------------------------------------------------------------------------- |
| `country`  | string | Optional\* | 2-letter ISO 3166-1 code (e.g., `us`, `gb`, `jp`, `vn`)                             |
| `category` | string | Optional   | `business`, `entertainment`, `general`, `health`, `science`, `sports`, `technology` |
| `sources`  | string | Optional\* | Comma-separated source IDs (max 20)                                                 |
| `q`        | string | Optional   | Keywords to search for in headlines                                                 |
| `pageSize` | int    | Optional   | Number of results per page (max 100, default 20)                                    |
| `page`     | int    | Optional   | Page number (default 1)                                                             |

\*Cannot mix `country`/`category` with `sources` parameter

### Supported Countries

| Code | Country        | Code | Country   | Code | Country     |
| ---- | -------------- | ---- | --------- | ---- | ----------- |
| `ae` | UAE            | `ar` | Argentina | `at` | Austria     |
| `au` | Australia      | `be` | Belgium   | `bg` | Bulgaria    |
| `br` | Brazil         | `ca` | Canada    | `ch` | Switzerland |
| `cn` | China          | `co` | Colombia  | `cu` | Cuba        |
| `cz` | Czech Republic | `de` | Germany   | `eg` | Egypt       |
| `fr` | France         | `gb` | UK        | `gr` | Greece      |
| `hk` | Hong Kong      | `hu` | Hungary   | `id` | Indonesia   |
| `ie` | Ireland        | `il` | Israel    | `in` | India       |
| `it` | Italy          | `jp` | Japan     | `kr` | South Korea |
| `lt` | Lithuania      | `lv` | Latvia    | `ma` | Morocco     |
| `mx` | Mexico         | `my` | Malaysia  | `ng` | Nigeria     |
| `nl` | Netherlands    | `no` | Norway    | `nz` | New Zealand |
| `ph` | Philippines    | `pl` | Poland    | `pt` | Portugal    |
| `ro` | Romania        | `rs` | Serbia    | `ru` | Russia      |
| `sa` | Saudi Arabia   | `se` | Sweden    | `sg` | Singapore   |
| `si` | Slovenia       | `sk` | Slovakia  | `th` | Thailand    |
| `tr` | Turkey         | `tw` | Taiwan    | `ua` | Ukraine     |
| `us` | USA            | `ve` | Venezuela | `vn` | Vietnam     |
| `za` | South Africa   |      |           |      |             |

### Categories

- `business` - Business news
- `entertainment` - Entertainment news
- `general` - General news (default)
- `health` - Health news
- `science` - Science news
- `sports` - Sports news
- `technology` - Technology news

### Response Schema

Same as `/everything` endpoint:

```json
{
  "status": "ok",
  "totalResults": 38,
  "articles": [
    {
      "source": {
        "id": "bbc-news",
        "name": "BBC News"
      },
      "author": "BBC News",
      "title": "Breaking: Major Event Headline",
      "description": "Description of the breaking news",
      "url": "https://bbc.com/news/article",
      "urlToImage": "https://image-url.jpg",
      "publishedAt": "2024-03-07T10:00:00Z",
      "content": "Article content..."
    }
  ]
}
```

### Example Requests

#### Top Headlines by Country

```bash
GET /top-headlines?country=us&apiKey=YOUR_API_KEY
```

#### Top Headlines by Category

```bash
GET /top-headlines?country=us&category=technology&apiKey=YOUR_API_KEY
```

#### Top Headlines from Specific Sources

```bash
GET /top-headlines?sources=bbc-news,cnn,reuters&apiKey=YOUR_API_KEY
```

#### Search in Top Headlines

```bash
GET /top-headlines?country=gb&q=brexit&apiKey=YOUR_API_KEY
```

#### Vietnam Technology Headlines

```bash
GET /top-headlines?country=vn&category=technology&apiKey=YOUR_API_KEY
```

---

## Endpoint 3: Sources

**URL**: `/sources`

**Method**: `GET`

**Description**: Returns information about news sources available on NewsAPI.

### Authentication

**Header**:

```
X-Api-Key: YOUR_API_KEY
```

**OR Query Parameter**:

```
apiKey=YOUR_API_KEY
```

### Request Parameters

| Parameter  | Type   | Required | Description                                        |
| ---------- | ------ | -------- | -------------------------------------------------- |
| `category` | string | Optional | Filter by category (business, entertainment, etc.) |
| `language` | string | Optional | Filter by 2-letter language code                   |
| `country`  | string | Optional | Filter by 2-letter country code                    |

### Response Schema

```json
{
  "status": "ok",
  "sources": [
    {
      "id": "bbc-news",
      "name": "BBC News",
      "description": "Use BBC News for up-to-the-minute news...",
      "url": "http://www.bbc.co.uk/news",
      "category": "general",
      "language": "en",
      "country": "gb"
    },
    {
      "id": "cnn",
      "name": "CNN",
      "description": "View the latest news and breaking news...",
      "url": "http://us.cnn.com",
      "category": "general",
      "language": "en",
      "country": "us"
    }
  ]
}
```

### Example Requests

#### All Available Sources

```bash
GET /sources?apiKey=YOUR_API_KEY
```

#### Technology Sources in English

```bash
GET /sources?category=technology&language=en&apiKey=YOUR_API_KEY
```

#### Vietnamese News Sources

```bash
GET /sources?country=vn&apiKey=YOUR_API_KEY
```

#### US Business Sources

```bash
GET /sources?country=us&category=business&apiKey=YOUR_API_KEY
```

---

## Comparison Table

| Feature            | Everything          | Top Headlines     | Sources          |
| ------------------ | ------------------- | ----------------- | ---------------- |
| **Purpose**        | Search all articles | Breaking news     | Source discovery |
| **Data Range**     | 1 month history     | Current only      | N/A              |
| **Keyword Search** | Yes                 | Optional          | No               |
| **Date Filter**    | Yes (from/to)       | No                | No               |
| **By Country**     | Via sources/domains | Yes (direct)      | Yes (filter)     |
| **By Category**    | Via sources         | Yes (direct)      | Yes (filter)     |
| **Sorting**        | 3 options           | By published date | Alphabetical     |
| **Results**        | Up to 100/page      | Up to 100/page    | All sources      |

---

## Rate Limits

**All Endpoints**:

**Developer Plan**:

- 100 requests per day total
- 1 month historical data (`/everything` only)

**Business Plans**: Higher limits, contact NewsAPI

---

## Best Practices

1. **Cache responses** to reduce API calls
2. **Use specific queries** to get relevant results
3. **Paginate results** for large datasets
4. **Handle errors gracefully** with fallback strategies
5. **Respect rate limits** to avoid API key suspension
6. **Use `/top-headlines`** for current breaking news
7. **Use `/everything`** for historical research
8. **Use `/sources`** to discover available news sources

---

**Official Documentation**:

- Everything: https://newsapi.org/docs/endpoints/everything
- Top Headlines: https://newsapi.org/docs/endpoints/top-headlines
- Sources: https://newsapi.org/docs/endpoints/sources
