#!/bin/bash

# Vercel Multi-Environment Deployment Script
# Usage: ./deploy.sh [environment]

ENVIRONMENT=${1:-preview}
PROJECT_NAME="hello-nextjs"

echo "🚀 Deploying to $ENVIRONMENT environment..."

case $ENVIRONMENT in
  "development" | "dev")
    echo "Deploying to Development..."
    npx vercel --prod --alias ${PROJECT_NAME}-dev.vercel.app
    echo "✅ Deployed to: https://${PROJECT_NAME}-dev.vercel.app"
    ;;
    
  "staging" | "stage")
    echo "Deploying to Staging..."
    npx vercel --prod --alias ${PROJECT_NAME}-staging.vercel.app
    echo "✅ Deployed to: https://${PROJECT_NAME}-staging.vercel.app"
    ;;
    
  "production" | "prod")
    echo "Deploying to Production..."
    npx vercel --prod
    echo "✅ Deployed to production!"
    ;;
    
  "preview")
    echo "Creating preview deployment..."
    npx vercel
    echo "✅ Preview deployment created!"
    ;;
    
  *)
    echo "❌ Unknown environment: $ENVIRONMENT"
    echo "Usage: ./deploy.sh [development|staging|production|preview]"
    exit 1
    ;;
esac

echo ""
echo "📝 Deployment URLs:"
echo "- Development: https://${PROJECT_NAME}-dev.vercel.app"
echo "- Staging: https://${PROJECT_NAME}-staging.vercel.app"
echo "- Production: https://${PROJECT_NAME}.vercel.app"