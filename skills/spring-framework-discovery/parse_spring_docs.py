import re
import sys

# Read HTML content from stdin
html_output = sys.stdin.read() if not sys.stdin.isatty() else ""

# Extract all href links
href_pattern = r'href="([^"]+)"'
all_links = re.findall(href_pattern, html_output)

# Filter for documentation links (exclude external, css, js, etc.)
doc_links = set()
base_url = "https://docs.spring.io/spring-framework/reference/"

for link in all_links:
    # Skip external links, assets, and fragments
    if (link.startswith('http') or 
        link.startswith('#') or 
        link.endswith('.css') or 
        link.endswith('.js') or 
        link.endswith('.svg') or 
        link.endswith('.png') or
        link == '.' or
        link == './'):
        continue
    
    # Clean up the link
    clean_link = link.replace('./', '')
    if clean_link and not clean_link.startswith('_'):
        doc_links.add(clean_link)

# Sort and display
sorted_links = sorted(doc_links)

print("=" * 80)
print("SPRING FRAMEWORK DOCUMENTATION - ALL DOCUMENT LINKS")
print("=" * 80)
print()
print(f"Base URL: {base_url}")
print(f"Total unique documentation pages found: {len(sorted_links)}")
print()
print("-" * 80)
print("DOCUMENTATION LINKS:")
print("-" * 80)

for i, link in enumerate(sorted_links, 1):
    full_url = base_url + link if not link.startswith('http') else link
    print(f"{i:3d}. {link}")
    if i % 20 == 0:
        print()

print()
print("=" * 80)
print("To access any document, use: " + base_url + "<link_path>")
print("=" * 80)