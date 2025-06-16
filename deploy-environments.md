# Vercel Multi-Environment Deployment Guide

## Environment Types in Vercel

Vercel supports three environment types:
1. **Production** - Your main production deployment
2. **Preview** - Deployments from feature branches
3. **Development** - Local development environment

## Deployment Methods

### Method 1: Using Git Branches (Recommended)

Each branch automatically creates a preview deployment:
- `main` → Production environment
- `staging` → Staging preview environment
- `develop` → Development preview environment

```bash
# Deploy to Development
git checkout develop
git push origin develop
# Creates: hello-nextjs-git-develop-[team].vercel.app

# Deploy to Staging
git checkout staging
git push origin staging
# Creates: hello-nextjs-git-staging-[team].vercel.app

# Deploy to Production
git checkout main
git push origin main
# Creates: hello-nextjs.vercel.app
```

### Method 2: Manual Deployment with Aliases

```bash
# Deploy to Development environment
npx vercel --prod --alias hello-nextjs-dev.vercel.app

# Deploy to Staging environment
npx vercel --prod --alias hello-nextjs-staging.vercel.app

# Deploy to Production
npx vercel --prod
```

### Method 3: Using Environment Variables

Create different deployments with environment-specific configs:

```bash
# Development deployment
npx vercel --build-env NODE_ENV=development --prod --alias dev.hello-nextjs.vercel.app

# Staging deployment
npx vercel --build-env NODE_ENV=staging --prod --alias staging.hello-nextjs.vercel.app

# Production deployment
npx vercel --build-env NODE_ENV=production --prod
```

## Setting Up Environment Variables in Vercel

1. Go to your Vercel project dashboard
2. Navigate to Settings → Environment Variables
3. Add variables for each environment:

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| NEXT_PUBLIC_API_URL | https://api-dev.example.com | https://api-staging.example.com | https://api.example.com |
| NEXT_PUBLIC_ENV | development | staging | production |

## Custom Domain Setup

For professional deployment URLs:

1. In Vercel Dashboard → Settings → Domains
2. Add custom domains:
   - `dev.yourdomain.com` → Development
   - `staging.yourdomain.com` → Staging  
   - `yourdomain.com` → Production

## Automated Deployment Script

Use the deployment script (see deploy.sh) to easily deploy to any environment:

```bash
./deploy.sh development
./deploy.sh staging
./deploy.sh production
```