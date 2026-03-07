# GitHub REST API Documentation - Complete Link Index

**Base URL:** https://docs.github.com/en/rest

**API Version:** 2022-11-28

**Total API Categories:** 40+

---

## Overview & Getting Started

- https://docs.github.com/en/rest/overview - REST API Overview
- https://docs.github.com/en/rest/guides - API Guides
- https://docs.github.com/en/rest/quickstart - Quickstart
- https://docs.github.com/en/rest/about-the-rest-api/about-the-rest-api - About the REST API
- https://docs.github.com/en/rest/about-the-rest-api/api-versions - API Versions
- https://docs.github.com/en/rest/about-the-rest-api/authenticating-to-the-rest-api - Authentication
- https://docs.github.com/en/rest/about-the-rest-api/rate-limits-for-the-rest-api - Rate Limits

---

## Core API Categories

### 1. Repositories

**Base**: https://docs.github.com/en/rest/repos

- /repos - Repositories
- /repos/repos - Get, create, update, delete repositories
- /repos/contents - Repository contents (files, directories)
- /repos/commits - Commits
- /repos/branches - Branches
- /repos/collaborators - Collaborators
- /repos/comments - Commit comments
- /repos/deployments - Deployments
- /repos/forks - Forks
- /repos/releases - Releases
- /repos/statistics - Statistics
- /repos/statuses - Statuses
- /repos/tags - Tags
- /repos/webhooks - Webhooks

**Key Endpoints**:

```
GET /repos/{owner}/{repo}
GET /repos/{owner}/{repo}/contents/{path}
GET /repos/{owner}/{repo}/commits
GET /repos/{owner}/{repo}/branches
POST /repos/{owner}/{repo}/contents/{path}
```

### 2. Search

**Base**: https://docs.github.com/en/rest/search

- /search - Search API
- /search/code - Search code
- /search/commits - Search commits
- /search/issues - Search issues and pull requests
- /search/labels - Search labels
- /search/repositories - Search repositories
- /search/topics - Search topics
- /search/users - Search users

**Key Endpoints**:

```
GET /search/code?q={query}
GET /search/repositories?q={query}
GET /search/issues?q={query}
GET /search/users?q={query}
```

### 3. Pull Requests

**Base**: https://docs.github.com/en/rest/pulls

- /pulls - Pull Requests
- /pulls/pulls - List, get, create, update pull requests
- /pulls/reviews - Pull request reviews
- /pulls/review-comments - Review comments
- /pulls/review-requests - Review requests
- /pulls/commits - Pull request commits
- /pulls/files - Pull request files (diff)
- /pulls/merges - Merging pull requests

**Key Endpoints**:

```
GET /repos/{owner}/{repo}/pulls
GET /repos/{owner}/{repo}/pulls/{pull_number}
GET /repos/{owner}/{repo}/pulls/{pull_number}/files
GET /repos/{owner}/{repo}/pulls/{pull_number}/comments
GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews
POST /repos/{owner}/{repo}/pulls/{pull_number}/comments
POST /repos/{owner}/{repo}/pulls/{pull_number}/reviews
```

### 4. Issues

**Base**: https://docs.github.com/en/rest/issues

- /issues - Issues
- /issues/issues - List, get, create, update issues
- /issues/assignees - Assignees
- /issues/comments - Comments
- /issues/events - Events
- /issues/labels - Labels
- /issues/milestones - Milestones
- /issues/timeline - Timeline

**Key Endpoints**:

```
GET /repos/{owner}/{repo}/issues
GET /repos/{owner}/{repo}/issues/{issue_number}
GET /repos/{owner}/{repo}/issues/{issue_number}/comments
POST /repos/{owner}/{repo}/issues/{issue_number}/comments
```

### 5. Git Data

**Base**: https://docs.github.com/en/rest/git

- /git - Git Database
- /git/blobs - Blobs
- /git/commits - Commits
- /git/refs - References
- /git/tags - Tags
- /git/trees - Trees

**Key Endpoints**:

```
GET /repos/{owner}/{repo}/git/ref/{ref}
GET /repos/{owner}/{repo}/git/commits/{sha}
GET /repos/{owner}/{repo}/git/trees/{sha}
GET /repos/{owner}/{repo}/git/blobs/{sha}
```

### 6. Code Review

**Base**: https://docs.github.com/en/rest/pulls

- /pulls/reviews - Reviews
- /pulls/review-comments - Single comments on pull requests
- /pulls/review-events - Review events

**Key Endpoints**:

```
GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews
POST /repos/{owner}/{repo}/pulls/{pull_number}/reviews
GET /repos/{owner}/{repo}/pulls/{pull_number}/comments
POST /repos/{owner}/{repo}/pulls/comments  (reply to review comment)
PUT /repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}
```

### 7. Users

**Base**: https://docs.github.com/en/rest/users

- /users - Users
- /users/users - Get users
- /users/followers - Followers
- /users/following - Following
- /users/emails - Emails
- /users/keys - SSH Keys

**Key Endpoints**:

```
GET /users/{username}
GET /user (authenticated user)
GET /users/{username}/repos
```

### 8. Organizations

**Base**: https://docs.github.com/en/rest/orgs

- /orgs - Organizations
- /orgs/orgs - Organization info
- /orgs/members - Members
- /orgs/teams - Teams

### 9. Gists

**Base**: https://docs.github.com/en/rest/gists

- /gists - Gists
- /gists/gists - List, create, update gists
- /gists/comments - Gist comments

### 10. Actions

**Base**: https://docs.github.com/en/rest/actions

- /actions - GitHub Actions
- /actions/artifacts - Artifacts
- /actions/cache - Cache
- /actions/jobs - Jobs
- /actions/runs - Workflow runs
- /actions/workflows - Workflows
- /actions/secrets - Secrets

---

## Advanced Features

### 11. Apps

**Base**: https://docs.github.com/en/rest/apps

- /apps - GitHub Apps
- /apps/installations - Installations
- /apps/permissions - Permissions

### 12. Webhooks

**Base**: https://docs.github.com/en/rest/webhooks

- /webhooks - Webhooks
- /repos/webhooks - Repository webhooks
- /orgs/webhooks - Organization webhooks

### 13. Notifications

**Base**: https://docs.github.com/en/rest/activity/notifications

- /notifications - Notifications
- /notifications/threads - Threads

### 14. Checks

**Base**: https://docs.github.com/en/rest/checks

- /checks - Checks
- /checks/runs - Check runs
- /checks/suites - Check suites

### 15. Dependency Graph

**Base**: https://docs.github.com/en/rest/dependency-graph

- /dependency-graph - Dependency Graph
- /dependency-graph/sboms - SBOMs

---

## Common Workflows

### For Code Discovery & Investigation

1. **Search Code**: `/search/code?q={query}`
2. **Search Repositories**: `/search/repositories?q={query}`
3. **Get Repository**: `/repos/{owner}/{repo}`
4. **Get File Content**: `/repos/{owner}/{repo}/contents/{path}`
5. **Search Users**: `/search/users?q={query}`

### For PR Review Workflow

1. **List PRs**: `/repos/{owner}/{repo}/pulls`
2. **Get PR Details**: `/repos/{owner}/{repo}/pulls/{pull_number}`
3. **Get PR Files (Diff)**: `/repos/{owner}/{repo}/pulls/{pull_number}/files`
4. **Get PR Comments**: `/repos/{owner}/{repo}/pulls/{pull_number}/comments`
5. **Get PR Reviews**: `/repos/{owner}/{repo}/pulls/{pull_number}/reviews`
6. **Post Review Comment**: `/repos/{owner}/{repo}/pulls/{pull_number}/comments`
7. **Submit Review**: `/repos/{owner}/{repo}/pulls/{pull_number}/reviews`

### For Branch Comparison

1. **Compare Branches**: `/repos/{owner}/{repo}/compare/{base}...{head}`
2. **Get Branch**: `/repos/{owner}/{repo}/branches/{branch}`
3. **Get Commits**: `/repos/{owner}/{repo}/commits?sha={branch}`

---

## Rate Limits

**Authenticated Requests**:

- 5,000 requests per hour
- Search API: 30 requests per minute

**Unauthenticated Requests**:

- 60 requests per hour
- Search API: 10 requests per minute

---

## Authentication Methods

1. **Personal Access Token (PAT)**:

   ```
   Authorization: token ghp_xxxxxxxxxxxx
   ```

2. **GitHub App**:

   ```
   Authorization: Bearer <JWT>
   ```

3. **OAuth App**:

   ```
   Authorization: Bearer <OAuth token>
   ```

4. **GitHub CLI (gh)**:
   ```bash
   gh api /repos/{owner}/{repo}
   ```

---

## Response Format

All responses are in JSON format:

```json
{
  "id": 123456,
  "name": "repo-name",
  "full_name": "owner/repo-name",
  "html_url": "https://github.com/owner/repo-name",
  ...
}
```

---

## Best Practices

✅ **Always specify API version**: `X-GitHub-Api-Version: 2022-11-28`
✅ **Use conditional requests**: Use ETags for caching
✅ **Respect rate limits**: Check `X-RateLimit-Remaining` header
✅ **Use pagination**: Most list endpoints return 30 items by default
✅ **Use GraphQL for complex queries**: More efficient than multiple REST calls

❌ **Don't poll excessively**: Use webhooks instead
❌ **Don't ignore rate limits**: Will result in 403 errors
❌ **Don't hardcode tokens**: Use environment variables

---

## Quick Reference - Most Used Endpoints

| Purpose          | Endpoint                                        | Method |
| ---------------- | ----------------------------------------------- | ------ |
| Search code      | `/search/code?q={query}`                        | GET    |
| Search repos     | `/search/repositories?q={query}`                | GET    |
| Get repo         | `/repos/{owner}/{repo}`                         | GET    |
| Get file         | `/repos/{owner}/{repo}/contents/{path}`         | GET    |
| List PRs         | `/repos/{owner}/{repo}/pulls`                   | GET    |
| Get PR           | `/repos/{owner}/{repo}/pulls/{number}`          | GET    |
| PR diff          | `/repos/{owner}/{repo}/pulls/{number}/files`    | GET    |
| PR comments      | `/repos/{owner}/{repo}/pulls/{number}/comments` | GET    |
| Post comment     | `/repos/{owner}/{repo}/pulls/{number}/comments` | POST   |
| Compare branches | `/repos/{owner}/{repo}/compare/{base}...{head}` | GET    |

---

**Documentation**: https://docs.github.com/en/rest  
**API Status**: https://www.githubstatus.com/  
**Best Practices**: https://docs.github.com/en/rest/guides/best-practices-for-using-the-rest-api

**Generated on:** 2026-03-07  
**API Version:** 2022-11-28
