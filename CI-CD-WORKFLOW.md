# CI/CD Workflow Documentation

## Overview

This project uses GitHub Actions for automated CI/CD with Vercel deployments. The workflow follows a branch-based deployment strategy with automated testing and linting.

## Deployment Strategy

### Branch-Based Deployments

| Branch | Environment | URL | Trigger |
|--------|-------------|-----|---------|
| `main` | Production | https://hello-nextjs.vercel.app | Push to main |
| `staging` | Staging | https://hello-nextjs-staging.vercel.app | Push to staging |
| `feature/*` | Preview | Dynamic preview URL | Pull Request |

### Workflow Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Feature   │     │   Staging   │     │ Production  │
│   Branch    │     │   Branch    │     │   (main)    │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                    │
       ▼                   ▼                    ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ Pull Request│     │Push to      │     │Push to main │
│   Opened    │     │  staging    │     │             │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                    │
       ▼                   ▼                    ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│Test & Lint  │     │Test & Lint  │     │Test & Lint  │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                    │
       ▼                   ▼                    ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Deploy    │     │   Deploy    │     │   Deploy    │
│  Preview    │     │  Staging    │     │ Production  │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                    │
       ▼                   ▼                    ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ PR Comment  │     │Environment  │     │GitHub       │
│ with URL    │     │   Ready     │     │Release      │
└─────────────┘     └─────────────┘     └─────────────┘
```

## Workflows

### 1. Preview Deployment (`.github/workflows/preview.yml`)

**Trigger:** Pull requests to any branch
**Purpose:** Create preview deployments for code review

**Steps:**
1. Run ESLint
2. Run TypeScript type checking
3. Run tests (if configured)
4. Deploy to Vercel preview
5. Comment on PR with preview URL

### 2. Staging Deployment (`.github/workflows/staging.yml`)

**Trigger:** Push to `staging` branch
**Purpose:** Deploy to staging environment for QA testing

**Steps:**
1. Run full test suite
2. Build application
3. Deploy to staging environment
4. Create deployment summary

### 3. Production Deployment (`.github/workflows/production.yml`)

**Trigger:** Push to `main` branch
**Purpose:** Deploy to production with full validation

**Steps:**
1. Run comprehensive tests
2. Build production bundle
3. Deploy to production
4. Create GitHub release
5. Generate deployment summary

## Best Practices

### 1. Branch Protection

Configure branch protection rules:

```bash
# Protect main branch
gh api repos/$(gh api user --jq .login)/hello-nextjs/branches/main/protection \
  --method PUT \
  -f enforce_admins=false \
  -f required_pull_request_reviews[required_approving_review_count]=1 \
  -f required_pull_request_reviews[dismiss_stale_reviews]=true

# Protect staging branch
gh api repos/$(gh api user --jq .login)/hello-nextjs/branches/staging/protection \
  --method PUT \
  -f enforce_admins=false \
  -f required_pull_request_reviews[required_approving_review_count]=1
```

### 2. Environment Variables

Set environment-specific variables in Vercel Dashboard:

1. Go to Project Settings → Environment Variables
2. Add variables for each environment:
   - Development: Variables for preview deployments
   - Preview: Variables for staging
   - Production: Variables for production

### 3. Secrets Management

Required GitHub secrets:
- `VERCEL_TOKEN`: Your Vercel access token
- `VERCEL_ORG_ID`: Your organization ID
- `VERCEL_PROJECT_ID`: Your project ID

### 4. Deployment Flow

**Recommended workflow:**

1. Create feature branch from `main`
   ```bash
   git checkout -b feature/new-feature
   ```

2. Make changes and push
   ```bash
   git add .
   git commit -m "feat: add new feature"
   git push origin feature/new-feature
   ```

3. Open pull request → Preview deployment created

4. After approval, merge to `staging`
   ```bash
   git checkout staging
   git merge feature/new-feature
   git push origin staging
   ```

5. After QA approval, merge to `main`
   ```bash
   git checkout main
   git merge staging
   git push origin main
   ```

## Monitoring and Rollback

### Viewing Deployments

1. **GitHub Actions:** Check workflow runs in Actions tab
2. **Vercel Dashboard:** Monitor deployments at https://vercel.com/dashboard
3. **Deployment URLs:**
   - Production: https://hello-nextjs.vercel.app
   - Staging: https://hello-nextjs-staging.vercel.app
   - Preview: Dynamic URLs in PR comments

### Rollback Procedures

**Quick rollback via Vercel:**
```bash
# List recent deployments
vercel ls

# Rollback to specific deployment
vercel rollback [deployment-url]
```

**Rollback via Git:**
```bash
# Revert commit on main
git revert HEAD
git push origin main
```

## Troubleshooting

### Common Issues

1. **Build failures:** Check logs in GitHub Actions
2. **Environment variables:** Verify in Vercel dashboard
3. **Permissions:** Ensure GitHub secrets are set correctly

### Debug Commands

```bash
# Verify Vercel connection
vercel whoami

# Check project link
vercel project ls

# Test build locally
npm run build
```

## Manual Deployment

If needed, you can still deploy manually:

```bash
# Deploy to specific environment
./deploy.sh staging

# Or use Vercel CLI directly
vercel --prod --alias hello-nextjs-staging.vercel.app
```

---

This CI/CD setup ensures code quality, automates deployments, and provides a reliable workflow for team collaboration.