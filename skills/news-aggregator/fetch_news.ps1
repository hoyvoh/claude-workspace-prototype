# NewsAPI Fetcher - PowerShell Script
# Works natively on Windows (PowerShell 5.1+)

# Configuration
$BaseUrl = "https://newsapi.org/v2"
$ApiKey = $env:NEWS_API_KEY
$OutputFile = "news_report.md"

# Default values
$Endpoint = "everything"
$Query = ""
$Sources = ""
$Domains = ""
$FromDate = ""
$ToDate = ""
$Language = "en"
$SortBy = "publishedAt"
$Country = ""
$Category = ""
$PageSize = 20
$Page = 1
$JsonOutput = $false

# Help function
function Show-Help {
    Write-Host @"
NewsAPI Fetcher - PowerShell Script Version

Usage: .\fetch_news.ps1 [OPTIONS]

Endpoints:
  -Endpoint <TYPE>      Endpoint to use: everything, headlines, sources (default: everything)

Common Options:
  -Query <TEXT>         Search query
  -Sources <LIST>       Comma-separated source IDs
  -PageSize <NUM>       Results per page (default: 20, max: 100)
  -Page <NUM>           Page number (default: 1)
  -Output <FILE>        Output filename (default: news_report.md)
  -Json                 Output as JSON

Everything Endpoint:
  -Domains <LIST>       Comma-separated domains
  -From <DATE>          Start date (YYYY-MM-DD)
  -To <DATE>            End date (YYYY-MM-DD)
  -Language <CODE>      Language code (en, vi, es, etc.)
  -SortBy <TYPE>        Sort by: relevancy, popularity, publishedAt

Headlines Endpoint:
  -Country <CODE>       Country code (us, gb, vn, etc.)
  -Category <TYPE>      Category: business, entertainment, general, health, science, sports, technology

Sources Endpoint:
  -Country <CODE>       Filter by country
  -Language <CODE>      Filter by language
  -Category <TYPE>      Filter by category

Examples:
  # Everything - Search AI news
  .\fetch_news.ps1 -Endpoint everything -Query "artificial intelligence" -PageSize 10

  # Headlines - US technology news
  .\fetch_news.ps1 -Endpoint headlines -Country us -Category technology -PageSize 20

  # Sources - Vietnamese sources
  .\fetch_news.ps1 -Endpoint sources -Country vn -Output vn_sources.md

  # JSON output
  .\fetch_news.ps1 -Endpoint everything -Query "blockchain" -Json -Output data.json

"@
}

# Parse parameters
param(
    [string]$Endpoint = "everything",
    [string]$Query = "",
    [string]$Sources = "",
    [string]$Domains = "",
    [string]$From = "",
    [string]$To = "",
    [string]$Language = "en",
    [string]$SortBy = "publishedAt",
    [string]$Country = "",
    [string]$Category = "",
    [int]$PageSize = 20,
    [int]$Page = 1,
    [string]$Output = "news_report.md",
    [switch]$Json,
    [switch]$Help
)

# Show help if requested
if ($Help) {
    Show-Help
    exit 0
}

# Check if API key is set
if ([string]::IsNullOrEmpty($ApiKey)) {
    Write-Host "Error: NEWS_API_KEY environment variable not set" -ForegroundColor Red
    Write-Host "Get your API key from: https://newsapi.org/register"
    Write-Host ""
    Write-Host "Set it with:"
    Write-Host '  $env:NEWS_API_KEY = "your_key_here"  # PowerShell' -ForegroundColor Yellow
    Write-Host "  set NEWS_API_KEY=your_key_here       # cmd" -ForegroundColor Yellow
    exit 1
}

# Build URL and parameters based on endpoint
$Params = @{
    apiKey = $ApiKey
}

switch ($Endpoint.ToLower()) {
    "everything" {
        $Url = "$BaseUrl/everything"
        $Params.pageSize = $PageSize
        $Params.page = $Page
        $Params.language = $Language
        $Params.sortBy = $SortBy
        
        if ($Query) { $Params.q = $Query }
        if ($Sources) { $Params.sources = $Sources }
        if ($Domains) { $Params.domains = $Domains }
        if ($From) { $Params.from = $From }
        if ($To) { $Params.to = $To }
    }
    "headlines" {
        $Url = "$BaseUrl/top-headlines"
        $Params.pageSize = $PageSize
        $Params.page = $Page
        
        if ($Query) { $Params.q = $Query }
        if ($Sources) { $Params.sources = $Sources }
        if ($Country) { $Params.country = $Country }
        if ($Category) { $Params.category = $Category }
    }
    "sources" {
        $Url = "$BaseUrl/sources"
        
        if ($Country) { $Params.country = $Country }
        if ($Language) { $Params.language = $Language }
        if ($Category) { $Params.category = $Category }
    }
    default {
        Write-Host "Error: Invalid endpoint: $Endpoint" -ForegroundColor Red
        Write-Host "Valid endpoints: everything, headlines, sources"
        exit 1
    }
}

# Build query string
$QueryString = ($Params.GetEnumerator() | ForEach-Object { "$($_.Key)=$([System.Uri]::EscapeDataString($_.Value))" }) -join "&"
$FullUrl = "$Url?$QueryString"

# Make API request
Write-Host "Fetching from /$Endpoint..." -ForegroundColor Yellow

try {
    $Response = Invoke-RestMethod -Uri $FullUrl -Method Get -ErrorAction Stop
    
    # Check for API errors
    if ($Response.status -eq "error") {
        Write-Host "API Error: $($Response.message)" -ForegroundColor Red
        exit 1
    }
    
    # Output result
    if ($Json) {
        # Output as JSON
        $Response | ConvertTo-Json -Depth 10 | Out-File -FilePath $Output -Encoding UTF8
        Write-Host "Saved JSON to: $Output" -ForegroundColor Green
    }
    else {
        # Convert to Markdown
        $Markdown = @"
# News Report

**Generated**: $(Get-Date -Format "MMMM dd, yyyy 'at' hh:mm tt")

"@
        
        if ($Endpoint -eq "sources") {
            # Format sources
            $Markdown += @"

**Total Sources**: $($Response.sources.Count)

---

"@
            foreach ($source in $Response.sources) {
                $Markdown += @"

### $($source.name)

**ID**: ``$($source.id)``  
**URL**: $($source.url)  
**Language**: $($source.language)  
**Country**: $($source.country)  
**Category**: $($source.category)

$($source.description)

---

"@
            }
        }
        else {
            # Format articles
            $Markdown += @"

**Total Results**: $($Response.totalResults)  
**Articles Shown**: $($Response.articles.Count)

---

"@
            $index = 1
            foreach ($article in $Response.articles) {
                $publishedDate = if ($article.publishedAt) {
                    (Get-Date $article.publishedAt).ToString("MMMM dd, yyyy 'at' hh:mm tt 'UTC'")
                } else {
                    "Unknown Date"
                }
                
                $Markdown += @"

## $index. $($article.title)

**Source**: $($article.source.name)  
**Author**: $($article.author)  
**Published**: $publishedDate  
**URL**: [$($article.url)]($($article.url))

"@
                if ($article.urlToImage) {
                    $Markdown += "![Article Image]($($article.urlToImage))`n`n"
                }
                
                if ($article.description) {
                    $Markdown += @"
### Summary

$($article.description)

"@
                }
                
                if ($article.content -and $article.content -ne $article.description) {
                    $content = $article.content -replace '\[\+\d+ chars\]$', ''
                    if ($content) {
                        $Markdown += @"
### Content Preview

$content

"@
                    }
                }
                
                $Markdown += "---`n`n"
                $index++
            }
        }
        
        $Markdown += @"

---

*Powered by [NewsAPI](https://newsapi.org/)*
"@
        
        $Markdown | Out-File -FilePath $Output -Encoding UTF8
        Write-Host "Saved Markdown to: $Output" -ForegroundColor Green
        
        if ($Endpoint -ne "sources") {
            Write-Host "Total articles: $($Response.totalResults)" -ForegroundColor Cyan
        } else {
            Write-Host "Total sources: $($Response.sources.Count)" -ForegroundColor Cyan
        }
    }
    
    Write-Host "Done!" -ForegroundColor Green
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}