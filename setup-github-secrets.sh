#!/bin/bash

echo "GitHub Secrets Setup for Vercel Deployment"
echo "=========================================="
echo ""

# Display the project and org IDs we already have
echo "Your Vercel Project Information:"
echo "Project ID: prj_fj9f8hEfwn7QzBJDAqlwDukrs2kx"
echo "Organization ID: team_yJ50MovuhkkJR2MHTAgHJRoc"
echo ""

echo "Step 1: Generate Vercel Access Token"
echo "-----------------------------------"
echo "1. Go to: https://vercel.com/account/tokens"
echo "2. Click 'Create Token'"
echo "3. Give it a name (e.g., 'GitHub Actions')"
echo "4. Set expiration (recommended: 1 year)"
echo "5. Copy the token immediately (it won't be shown again)"
echo ""
echo "Press Enter once you have copied your token..."
read

echo ""
echo "Step 2: Add GitHub Secrets"
echo "-------------------------"
echo "Now run these commands (replace YOUR_VERCEL_TOKEN with your actual token):"
echo ""

# GitHub CLI commands to add secrets
cat << 'EOF'
# Add VERCEL_TOKEN (replace with your actual token)
gh secret set VERCEL_TOKEN --body="YOUR_VERCEL_TOKEN" --repo="$(gh api user --jq .login)/hello-nextjs"

# Add VERCEL_ORG_ID
gh secret set VERCEL_ORG_ID --body="team_yJ50MovuhkkJR2MHTAgHJRoc" --repo="$(gh api user --jq .login)/hello-nextjs"

# Add VERCEL_PROJECT_ID
gh secret set VERCEL_PROJECT_ID --body="prj_fj9f8hEfwn7QzBJDAqlwDukrs2kx" --repo="$(gh api user --jq .login)/hello-nextjs"
EOF

echo ""
echo "Step 3: Verify Secrets"
echo "---------------------"
echo "Run this command to verify all secrets are added:"
echo ""
echo 'gh secret list --repo="$(gh api user --jq .login)/hello-nextjs"'
echo ""
echo "You should see:"
echo "- VERCEL_TOKEN"
echo "- VERCEL_ORG_ID"
echo "- VERCEL_PROJECT_ID"