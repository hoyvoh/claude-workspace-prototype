#!/bin/bash
# Git Operations Configuration
# Expose domain and settings for easy modification

# GitHub Domain (can be changed for GitHub Enterprise)
export GIT_DOMAIN="${GIT_DOMAIN:-github.com}"
export GIT_API_URL="${GIT_API_URL:-https://api.github.com}"

# Default repository settings (can be overridden)
export DEFAULT_OWNER="${GIT_DEFAULT_OWNER:-}"
export DEFAULT_REPO="${GIT_DEFAULT_REPO:-}"
export DEFAULT_BRANCH="${GIT_DEFAULT_BRANCH:-main}"

# API Settings
export GIT_API_VERSION="2022-11-28"

# Output preferences
export VERBOSE="${GIT_VERBOSE:-false}"
export OUTPUT_FORMAT="${GIT_OUTPUT_FORMAT:-json}"

# Rate limit warnings
export WARN_RATE_LIMIT="${GIT_WARN_RATE_LIMIT:-true}"

# Example usage in scripts:
# source "$(dirname "$0")/../config/git-config.sh"
# gh api --hostname "${GIT_DOMAIN}" /repos/${OWNER}/${REPO}