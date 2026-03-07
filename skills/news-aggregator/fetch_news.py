#!/usr/bin/env python3
"""
NewsAPI Fetcher and Markdown Formatter

Fetches news articles from NewsAPI and formats them as Markdown.
"""

import os
import sys
import json
import requests
from datetime import datetime
from typing import Dict, List, Optional
from urllib.parse import urlencode

# API Configuration
BASE_URL = "https://newsapi.org/v2"
API_KEY = os.getenv("NEWS_API_KEY", "")


def fetch_everything(
    query: Optional[str] = None,
    sources: Optional[str] = None,
    domains: Optional[str] = None,
    from_date: Optional[str] = None,
    to_date: Optional[str] = None,
    language: str = "en",
    sort_by: str = "publishedAt",
    page_size: int = 20,
    page: int = 1,
) -> Dict:
    """
    Fetch news articles from /everything endpoint.
    
    Args:
        query: Search keywords
        sources: Comma-separated news source IDs
        domains: Comma-separated domains
        from_date: Start date (ISO 8601)
        to_date: End date (ISO 8601)
        language: 2-letter language code
        sort_by: Sort method (relevancy, popularity, publishedAt)
        page_size: Results per page (max 100)
        page: Page number
        
    Returns:
        API response dictionary
    """
    if not API_KEY:
        raise ValueError("NEWS_API_KEY environment variable not set")
    
    # Build parameters
    params = {
        "apiKey": API_KEY,
        "language": language,
        "sortBy": sort_by,
        "pageSize": page_size,
        "page": page,
    }
    
    if query:
        params["q"] = query
    if sources:
        params["sources"] = sources
    if domains:
        params["domains"] = domains
    if from_date:
        params["from"] = from_date
    if to_date:
        params["to"] = to_date
    
    # Make request
    url = f"{BASE_URL}/everything"
    response = requests.get(url, params=params, timeout=30)
    response.raise_for_status()
    
    return response.json()

def fetch_top_headlines(
    country: Optional[str] = None,
    category: Optional[str] = None,
    sources: Optional[str] = None,
    query: Optional[str] = None,
    page_size: int = 20,
    page: int = 1,
) -> Dict:
    """
    Fetch top headlines from /top-headlines endpoint.
    
    Args:
        country: 2-letter country code (e.g., us, gb, vn)
        category: Category (business, entertainment, general, health, science, sports, technology)
        sources: Comma-separated source IDs (cannot use with country/category)
        query: Search keywords
        page_size: Results per page (max 100)
        page: Page number
        
    Returns:
        API response dictionary
    """
    if not API_KEY:
        raise ValueError("NEWS_API_KEY environment variable not set")
    
    # Build parameters
    params = {
        "apiKey": API_KEY,
        "pageSize": page_size,
        "page": page,
    }
    
    if query:
        params["q"] = query
    if sources:
        params["sources"] = sources
    if country:
        params["country"] = country
    if category:
        params["category"] = category
    
    # Make request
    url = f"{BASE_URL}/top-headlines"
    response = requests.get(url, params=params, timeout=30)
    response.raise_for_status()
    
    return response.json()

def fetch_sources(
    category: Optional[str] = None,
    language: Optional[str] = None,
    country: Optional[str] = None,
) -> Dict:
    """
    Fetch available news sources from /sources endpoint.
    
    Args:
        category: Filter by category
        language: Filter by 2-letter language code
        country: Filter by 2-letter country code
        
    Returns:
        API response dictionary
    """
    if not API_KEY:
        raise ValueError("NEWS_API_KEY environment variable not set")
    
    # Build parameters
    params = {"apiKey": API_KEY}
    
    if category:
        params["category"] = category
    if language:
        params["language"] = language
    if country:
        params["country"] = country
    
    # Make request
    url = f"{BASE_URL}/sources"
    response = requests.get(url, params=params, timeout=30)
    response.raise_for_status()
    
    return response.json()


def format_article_markdown(article: Dict, index: int) -> str:
    """
    Format a single article as Markdown.
    
    Args:
        article: Article dictionary from API
        index: Article number
        
    Returns:
        Markdown formatted article
    """
    # Extract fields
    source = article.get("source", {}).get("name", "Unknown Source")
    author = article.get("author", "Unknown Author")
    title = article.get("title", "No Title")
    description = article.get("description", "")
    url = article.get("url", "")
    image_url = article.get("urlToImage", "")
    published = article.get("publishedAt", "")
    content = article.get("content", "")
    
    # Format published date
    if published:
        try:
            dt = datetime.fromisoformat(published.replace("Z", "+00:00"))
            published_formatted = dt.strftime("%B %d, %Y at %I:%M %p UTC")
        except:
            published_formatted = published
    else:
        published_formatted = "Unknown Date"
    
    # Build markdown
    md = f"## {index}. {title}\n\n"
    md += f"**Source**: {source}  \n"
    md += f"**Author**: {author}  \n"
    md += f"**Published**: {published_formatted}  \n"
    md += f"**URL**: [{url}]({url})  \n\n"
    
    if image_url:
        md += f"![Article Image]({image_url})\n\n"
    
    if description:
        md += f"### Summary\n\n{description}\n\n"
    
    if content and content != description:
        # Remove "[+xxxx chars]" suffix
        content_clean = content.split("[+")[0].strip()
        if content_clean:
            md += f"### Content Preview\n\n{content_clean}\n\n"
    
    md += "---\n\n"
    
    return md


def format_news_report(data: Dict, query: str = "") -> str:
    """
    Format complete news report as Markdown.
    
    Args:
        data: API response data
        query: Search query used
        
    Returns:
        Complete Markdown report
    """
    if data.get("status") != "ok":
        return f"# Error\n\n{data.get('message', 'Unknown error')}\n"
    
    articles = data.get("articles", [])
    total = data.get("totalResults", 0)
    
    # Header
    md = "# News Report\n\n"
    
    if query:
        md += f"**Search Query**: {query}  \n"
    
    md += f"**Total Results**: {total:,}  \n"
    md += f"**Articles Shown**: {len(articles)}  \n"
    md += f"**Generated**: {datetime.now().strftime('%B %d, %Y at %I:%M %p')}  \n\n"
    md += "---\n\n"
    
    # Articles
    for i, article in enumerate(articles, 1):
        md += format_article_markdown(article, i)
    
    # Footer
    md += "\n---\n\n"
    md += "*Powered by [NewsAPI](https://newsapi.org/)*\n"
    
    return md


def save_markdown(content: str, filename: str = "news_report.md") -> str:
    """Save markdown content to file."""
    with open(filename, "w", encoding="utf-8") as f:
        f.write(content)
    return filename


def format_sources_markdown(data: Dict) -> str:
    """Format sources list as Markdown."""
    if data.get("status") != "ok":
        return f"# Error\n\n{data.get('message', 'Unknown error')}\n"
    
    sources = data.get("sources", [])
    
    md = "# News Sources\n\n"
    md += f"**Total Sources**: {len(sources)}  \n"
    md += f"**Generated**: {datetime.now().strftime('%B %d, %Y at %I:%M %p')}  \n\n"
    md += "---\n\n"
    
    # Group by category
    by_category = {}
    for source in sources:
        category = source.get("category", "general")
        if category not in by_category:
            by_category[category] = []
        by_category[category].append(source)
    
    # Output by category
    for category in sorted(by_category.keys()):
        md += f"## {category.title()}\n\n"
        for source in sorted(by_category[category], key=lambda x: x.get("name", "")):
            md += f"### {source.get('name', 'Unknown')}\n\n"
            md += f"**ID**: `{source.get('id', '')}`  \n"
            md += f"**URL**: {source.get('url', '')}  \n"
            md += f"**Language**: {source.get('language', '')}  \n"
            md += f"**Country**: {source.get('country', '')}  \n\n"
            if source.get('description'):
                md += f"{source['description']}\n\n"
            md += "---\n\n"
    
    md += "\n*Powered by [NewsAPI](https://newsapi.org/)*\n"
    return md

def main():
    """Main CLI entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(description="Fetch news and format as Markdown")
    
    # Endpoint selection
    parser.add_argument("--endpoint", default="everything",
                       choices=["everything", "headlines", "sources"],
                       help="API endpoint to use")
    
    # Common parameters
    parser.add_argument("-q", "--query", help="Search query")
    parser.add_argument("-s", "--sources", help="News sources (comma-separated)")
    parser.add_argument("-n", "--page-size", type=int, default=20, 
                       help="Results per page (max 100)")
    parser.add_argument("-p", "--page", type=int, default=1, help="Page number")
    parser.add_argument("-o", "--output", default="news_report.md", 
                       help="Output filename")
    parser.add_argument("--json", action="store_true", 
                       help="Output as JSON instead of Markdown")
    
    # Everything endpoint parameters
    parser.add_argument("-d", "--domains", help="Domains (comma-separated)")
    parser.add_argument("-f", "--from-date", help="Start date (YYYY-MM-DD)")
    parser.add_argument("-t", "--to-date", help="End date (YYYY-MM-DD)")
    parser.add_argument("-l", "--language", default="en", help="Language code")
    parser.add_argument("--sort", default="publishedAt", 
                       choices=["relevancy", "popularity", "publishedAt"],
                       help="Sort method (everything only)")
    
    # Top headlines parameters
    parser.add_argument("-c", "--country", help="Country code (e.g., us, gb, vn)")
    parser.add_argument("--category", 
                       choices=["business", "entertainment", "general", "health", 
                               "science", "sports", "technology"],
                       help="News category")
    
    args = parser.parse_args()
    
    if not API_KEY:
        print("Error: NEWS_API_KEY environment variable not set", file=sys.stderr)
        print("Get your API key from: https://newsapi.org/register", file=sys.stderr)
        sys.exit(1)
    
    try:
        # Fetch based on endpoint
        print(f"Fetching from /{args.endpoint}...", file=sys.stderr)
        
        if args.endpoint == "sources":
            data = fetch_sources(
                category=args.category,
                language=args.language,
                country=args.country,
            )
        elif args.endpoint == "headlines":
            if not any([args.country, args.category, args.sources]):
                parser.error("headlines endpoint requires --country, --category, or --sources")
            data = fetch_top_headlines(
                country=args.country,
                category=args.category,
                sources=args.sources,
                query=args.query,
                page_size=args.page_size,
                page=args.page,
            )
        else:  # everything
            if not any([args.query, args.sources, args.domains]):
                parser.error("everything endpoint requires --query, --sources, or --domains")
            data = fetch_everything(
                query=args.query,
                sources=args.sources,
                domains=args.domains,
                from_date=args.from_date,
                to_date=args.to_date,
                language=args.language,
                sort_by=args.sort,
                page_size=args.page_size,
                page=args.page,
            )
        
        # Output results
        if args.json:
            output = json.dumps(data, indent=2)
            if args.output:
                save_markdown(output, args.output)
                print(f"Saved to: {args.output}", file=sys.stderr)
            else:
                print(output)
        else:
            if args.endpoint == "sources":
                markdown = format_sources_markdown(data)
            else:
                markdown = format_news_report(data, args.query or "")
            save_markdown(markdown, args.output)
            print(f"Saved to: {args.output}", file=sys.stderr)
            
            if args.endpoint != "sources":
                print(f"Total articles: {data.get('totalResults', 0)}", file=sys.stderr)
            else:
                print(f"Total sources: {len(data.get('sources', []))}", file=sys.stderr)
        
    except requests.exceptions.HTTPError as e:
        print(f"API Error: {e}", file=sys.stderr)
        if e.response is not None:
            print(f"Response: {e.response.text}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()