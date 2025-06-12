#!/bin/bash

# GitHub Repository Setup Script
# Run this script in a terminal where GitHub CLI is authenticated

echo "Starting GitHub repository setup..."

# 1. Create GitHub repository
echo "Creating GitHub repository..."
gh repo create hello-nextjs --public --description "A beautiful Hello World application built with Next.js, TypeScript, and Tailwind CSS" --source=. --remote=origin

# 2. Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

# 3. Create and push develop branch
echo "Creating develop branch..."
git checkout -b develop
git push -u origin develop

# 4. Create and push staging branch
echo "Creating staging branch..."
git checkout -b staging
git push -u origin staging

# 5. Switch back to main
git checkout main

# 6. Set up branch protection rules for main branch
echo "Setting up branch protection rules..."
gh api repos/$(gh api user --jq .login)/hello-nextjs/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":[]}' \
  --field enforce_admins=false \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field restrictions=null \
  --field allow_force_pushes=false \
  --field allow_deletions=false

echo "GitHub setup complete!"
echo ""
echo "Repository URL: https://github.com/$(gh api user --jq .login)/hello-nextjs"
echo "Branches created: main, develop, staging"
echo "Branch protection: Enabled for main branch"