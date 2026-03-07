#!/usr/bin/env python3
"""
GitHub API Content Fetcher

Fetch content from GitHub repository files using GitHub API.
Supports both REST API and GitHub CLI (gh).
"""

import sys
import json
import os
import base64
import argparse
from typing import Dict, Optional

def fetch_with_gh_cli(owner: str, repo: str, path: str, ref: str = "main") -> Optional[str]:
    """
    Fetch file content using GitHub CLI (gh).
    
    Args:
        owner: Repository owner
        repo: Repository name
        path: File path in repository
        ref: Branch/tag/commit (default: main)
        
    Returns:
        File content as string, or None if failed
    """
    import subprocess
    
    try:
        # Use gh api to fetch file content
        cmd = [
            "gh", "api",
            f"/repos/{owner}/{repo}/contents/{path}",
            "-H", "Accept: application/vnd.github+json",
            "-H", "X-GitHub-Api-Version: 2022-11-28"
        ]
        
        if ref and ref != "main":
            cmd.extend(["-F", f"ref={ref}"])
        
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        data = json.loads(result.stdout)
        
        # Decode base64 content
        if data.get("encoding") == "base64":
            content = base64.b64decode(data["content"]).decode('utf-8')
            return content
        
        return data.get("content", "")
        
    except subprocess.CalledProcessError as e:
        print(f"Error: gh CLI failed: {e.stderr}", file=sys.stderr)
        return None
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return None

def fetch_with_curl(owner: str, repo: str, path: str, ref: str = "main", token: Optional[str] = None) -> Optional[str]:
    """
    Fetch file content using curl (fallback method).
    
    Args:
        owner: Repository owner
        repo: Repository name
        path: File path in repository
        ref: Branch/tag/commit (default: main)
        token: GitHub personal access token (optional but recommended)
        
    Returns:
        File content as string, or None if failed
    """
    import subprocess
    
    url = f"https://api.github.com/repos/{owner}/{repo}/contents/{path}"
    if ref and ref != "main":
        url += f"?ref={ref}"
    
    cmd = ["curl", "-s", "-H", "Accept: application/vnd.github+json"]
    
    if token:
        cmd.extend(["-H", f"Authorization: token {token}"])
    
    cmd.extend(["-H", "X-GitHub-Api-Version: 2022-11-28", url])
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        data = json.loads(result.stdout)
        
        if "message" in data:
            print(f"Error: {data['message']}", file=sys.stderr)
            return None
        
        # Decode base64 content
        if data.get("encoding") == "base64":
            content = base64.b64decode(data["content"]).decode('utf-8')
            return content
        
        return data.get("content", "")
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return None

def fetch_file_content(owner: str, repo: str, path: str, ref: str = "main", use_cli: bool = True) -> Optional[str]:
    """
    Fetch file content from GitHub repository.
    
    Args:
        owner: Repository owner
        repo: Repository name
        path: File path in repository
        ref: Branch/tag/commit (default: main)
        use_cli: Use GitHub CLI if available (default: True)
        
    Returns:
        File content as string, or None if failed
    """
    # Try GitHub CLI first if requested
    if use_cli:
        content = fetch_with_gh_cli(owner, repo, path, ref)
        if content:
            return content
        print("GitHub CLI failed, trying curl...", file=sys.stderr)
    
    # Fallback to curl
    token = os.getenv("GITHUB_TOKEN") or os.getenv("GH_TOKEN")
    return fetch_with_curl(owner, repo, path, ref, token)

def main():
    parser = argparse.ArgumentParser(
        description="Fetch file content from GitHub repository",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Fetch a file using gh CLI
  python fetch_github_api.py spring-projects spring-framework README.md
  
  # Fetch from specific branch
  python fetch_github_api.py spring-projects spring-framework pom.xml --ref 6.1.x
  
  # Force use of curl with token
  export GITHUB_TOKEN=ghp_xxxx
  python fetch_github_api.py owner repo file.txt --no-cli
  
  # Fetch and save to file
  python fetch_github_api.py owner repo src/Main.java > Main.java
        """
    )
    
    parser.add_argument("owner", help="Repository owner")
    parser.add_argument("repo", help="Repository name")
    parser.add_argument("path", help="File path in repository")
    parser.add_argument("--ref", default="main", help="Branch/tag/commit (default: main)")
    parser.add_argument("--no-cli", action="store_true", help="Don't use GitHub CLI, use curl directly")
    parser.add_argument("--output", "-o", help="Output file (default: stdout)")
    
    args = parser.parse_args()
    
    # Fetch content
    print(f"Fetching {args.owner}/{args.repo}/{args.path} (ref: {args.ref})...", file=sys.stderr)
    
    content = fetch_file_content(
        args.owner,
        args.repo,
        args.path,
        args.ref,
        use_cli=not args.no_cli
    )
    
    if content is None:
        print("Failed to fetch file content", file=sys.stderr)
        sys.exit(1)
    
    # Output
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Saved to {args.output}", file=sys.stderr)
    else:
        print(content)
    
    print(f"Success! ({len(content)} characters)", file=sys.stderr)

if __name__ == "__main__":
    main()