#!/bin/bash
# NewsAPI Fetcher - Cross-platform Shell Script
# Works on Mac, Linux, and Git Bash on Windows

# Configuration
BASE_URL="https://newsapi.org/v2"
API_KEY="${NEWS_API_KEY}"
OUTPUT_FILE="news_report.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if API key is set
if [ -z "$API_KEY" ]; then
    echo -e "${RED}Error: NEWS_API_KEY environment variable not set${NC}"
    echo "Get your API key from: https://newsapi.org/register"
    echo ""
    echo "Set it with:"
    echo "  export NEWS_API_KEY='your_key_here'  # Mac/Linux"
    echo "  set NEWS_API_KEY=your_key_here       # Windows cmd"
    exit 1
fi

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is not installed${NC}"
    echo "Please install curl to use this script"
    exit 1
fi

# Default values
ENDPOINT="everything"
QUERY=""
SOURCES=""
DOMAINS=""
FROM_DATE=""
TO_DATE=""
LANGUAGE="en"
SORT_BY="publishedAt"
COUNTRY=""
CATEGORY=""
PAGE_SIZE="20"
PAGE="1"
JSON_OUTPUT=false

# Help function
show_help() {
    cat << EOF
NewsAPI Fetcher - Shell Script Version

Usage: $0 [OPTIONS]

Endpoints:
  --endpoint TYPE       Endpoint to use: everything, headlines, sources (default: everything)

Common Options:
  -q, --query TEXT      Search query
  -s, --sources LIST    Comma-separated source IDs
  -n, --page-size NUM   Results per page (default: 20, max: 100)
  -p, --page NUM        Page number (default: 1)
  -o, --output FILE     Output filename (default: news_report.md)
  --json                Output as JSON

Everything Endpoint:
  -d, --domains LIST    Comma-separated domains
  -f, --from DATE       Start date (YYYY-MM-DD)
  -t, --to DATE         End date (YYYY-MM-DD)
  -l, --language CODE   Language code (en, vi, es, etc.)
  --sort TYPE           Sort by: relevancy, popularity, publishedAt

Headlines Endpoint:
  -c, --country CODE    Country code (us, gb, vn, etc.)
  --category TYPE       Category: business, entertainment, general, health, science, sports, technology

Sources Endpoint:
  -c, --country CODE    Filter by country
  -l, --language CODE   Filter by language
  --category TYPE       Filter by category

Examples:
  # Everything - Search AI news
  $0 --endpoint everything -q "artificial intelligence" -n 10

  # Headlines - US technology news
  $0 --endpoint headlines -c us --category technology -n 20

  # Sources - Vietnamese sources
  $0 --endpoint sources -c vn -o vn_sources.md

  # JSON output
  $0 --endpoint everything -q "blockchain" --json -o data.json

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --endpoint)
            ENDPOINT="$2"
            shift 2
            ;;
        -q|--query)
            QUERY="$2"
            shift 2
            ;;
        -s|--sources)
            SOURCES="$2"
            shift 2
            ;;
        -d|--domains)
            DOMAINS="$2"
            shift 2
            ;;
        -f|--from)
            FROM_DATE="$2"
            shift 2
            ;;
        -t|--to)
            TO_DATE="$2"
            shift 2
            ;;
        -l|--language)
            LANGUAGE="$2"
            shift 2
            ;;
        --sort)
            SORT_BY="$2"
            shift 2
            ;;
        -c|--country)
            COUNTRY="$2"
            shift 2
            ;;
        --category)
            CATEGORY="$2"
            shift 2
            ;;
        -n|--page-size)
            PAGE_SIZE="$2"
            shift 2
            ;;
        -p|--page)
            PAGE="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        --json)
            JSON_OUTPUT=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Build URL based on endpoint
case $ENDPOINT in
    everything)
        URL="${BASE_URL}/everything"
        PARAMS="apiKey=${API_KEY}&pageSize=${PAGE_SIZE}&page=${PAGE}&language=${LANGUAGE}&sortBy=${SORT_BY}"
        [ -n "$QUERY" ] && PARAMS="${PARAMS}&q=${QUERY}"
        [ -n "$SOURCES" ] && PARAMS="${PARAMS}&sources=${SOURCES}"
        [ -n "$DOMAINS" ] && PARAMS="${PARAMS}&domains=${DOMAINS}"
        [ -n "$FROM_DATE" ] && PARAMS="${PARAMS}&from=${FROM_DATE}"
        [ -n "$TO_DATE" ] && PARAMS="${PARAMS}&to=${TO_DATE}"
        ;;
    headlines)
        URL="${BASE_URL}/top-headlines"
        PARAMS="apiKey=${API_KEY}&pageSize=${PAGE_SIZE}&page=${PAGE}"
        [ -n "$QUERY" ] && PARAMS="${PARAMS}&q=${QUERY}"
        [ -n "$SOURCES" ] && PARAMS="${PARAMS}&sources=${SOURCES}"
        [ -n "$COUNTRY" ] && PARAMS="${PARAMS}&country=${COUNTRY}"
        [ -n "$CATEGORY" ] && PARAMS="${PARAMS}&category=${CATEGORY}"
        ;;
    sources)
        URL="${BASE_URL}/sources"
        PARAMS="apiKey=${API_KEY}"
        [ -n "$COUNTRY" ] && PARAMS="${PARAMS}&country=${COUNTRY}"
        [ -n "$LANGUAGE" ] && PARAMS="${PARAMS}&language=${LANGUAGE}"
        [ -n "$CATEGORY" ] && PARAMS="${PARAMS}&category=${CATEGORY}"
        ;;
    *)
        echo -e "${RED}Error: Invalid endpoint: $ENDPOINT${NC}"
        echo "Valid endpoints: everything, headlines, sources"
        exit 1
        ;;
esac

# Make API request
echo -e "${YELLOW}Fetching from /${ENDPOINT}...${NC}" >&2
RESPONSE=$(curl -s "${URL}?${PARAMS}")

# Check for errors
if echo "$RESPONSE" | grep -q '"status":"error"'; then
    echo -e "${RED}API Error:${NC}" >&2
    echo "$RESPONSE" | grep -o '"message":"[^"]*"' | cut -d'"' -f4 >&2
    exit 1
fi

# Output result
if [ "$JSON_OUTPUT" = true ]; then
    # Output as JSON
    echo "$RESPONSE" > "$OUTPUT_FILE"
    echo -e "${GREEN}Saved JSON to: $OUTPUT_FILE${NC}" >&2
else
    # Convert to Markdown (simplified version)
    echo "# News Report" > "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "**Generated**: $(date '+%B %d, %Y at %I:%M %p')" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    if [ "$ENDPOINT" = "sources" ]; then
        # Format sources
        echo "**Total Sources**: $(echo "$RESPONSE" | grep -o '"sources":\[' | wc -l)" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "$RESPONSE" | sed 's/{"id":"/\n### /g' | sed 's/","name":"/\n**Name**: /g' >> "$OUTPUT_FILE"
    else
        # Format articles
        TOTAL=$(echo "$RESPONSE" | grep -o '"totalResults":[0-9]*' | cut -d':' -f2)
        echo "**Total Results**: $TOTAL" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        
        # Extract and format articles (basic)
        echo "$RESPONSE" | sed 's/{"source":{/\n## Article\n\n/g' >> "$OUTPUT_FILE"
    fi
    
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "*Powered by [NewsAPI](https://newsapi.org/)*" >> "$OUTPUT_FILE"
    
    echo -e "${GREEN}Saved Markdown to: $OUTPUT_FILE${NC}" >&2
fi

echo -e "${GREEN}Done!${NC}" >&2