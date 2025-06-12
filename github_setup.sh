#!/bin/bash

set -e  # Exit on any error

echo "Starting GitHub repository setup..."

# Ensure we're in a git repository with at least one commit
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
fi

# Ensure we're on main branch
git checkout -B main
	
echo "Creating GitHub repository..."
# Create GitHub repository with single-line description
gh repo create hello-nextjs \
    --public \
    --description "A beautiful Hello World application built with Next.js, TypeScript, and Tailwind CSS" \
    --source=. \
    --remote=origin

echo "Pushing to GitHub..."
# Push to GitHub
git push -u origin main

echo "Creating and pushing develop branch..."
# Create and push develop branch
git checkout -b develop
git push -u origin develop

echo "Creating and pushing staging branch..."
# Create and push staging branch  
git checkout -b staging
git push -u origin staging

echo "Switching back to main..."
# Switch back to main
git checkout main

echo "Setting up branch protection rules..."
# Wait a moment for GitHub to fully create the repository
sleep 2

# Set up branch protection rules
gh api repos/$(gh api user --jq .login)/hello-nextjs/branches/main/protection \
    --method PUT \
    --field required_status_checks='{"strict":true,"contexts":[]}' \
    --field enforce_admins=false \
    --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
    --field restrictions=null \
    --field allow_force_pushes=false \
    --field allow_deletions=false

echo "GitHub repository setup completed successfully!"
echo "Repository URL: https://github.com/$(gh api user --jq .login)/hello-nextjs"
