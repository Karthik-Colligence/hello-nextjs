# Hello Next.js

A beautiful Hello World application built with Next.js, TypeScript, and Tailwind CSS.

## 🚀 Features

- **Next.js 15** with App Router
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Turbopack** for fast development
- **ESLint** for code quality
- **Responsive Design** for all devices
- **CI/CD Pipeline** with GitHub Actions
- **Multi-environment deployments** via Vercel

## 📋 Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Karthik-Colligence/hello-nextjs.git
cd hello-nextjs
```

2. Install dependencies:
```bash
npm install
```

3. Run the development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## 🛠️ Available Scripts

- `npm run dev` - Start development server with Turbopack
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript type checking
- `npm test` - Run tests

## 🌐 Deployment

This project uses a multi-environment deployment strategy:

### Environments

- **Production**: [https://hello-nextjs.vercel.app](https://hello-nextjs.vercel.app)
- **Staging**: [https://hello-nextjs-staging.vercel.app](https://hello-nextjs-staging.vercel.app)
- **Preview**: Dynamic URLs for pull requests

### Deployment Process

1. **Feature Development**: Create PR → Automatic preview deployment
2. **Staging**: Merge to `staging` branch → Automatic staging deployment
3. **Production**: Merge to `main` branch → Automatic production deployment

## 🔧 CI/CD Pipeline

The project includes GitHub Actions workflows for:

- **Pull Request Preview**: Automatic deployments for code review
- **Staging Deployment**: QA and testing environment
- **Production Deployment**: Final production releases with GitHub releases

See [CI-CD-WORKFLOW.md](./CI-CD-WORKFLOW.md) for detailed documentation.

## 📁 Project Structure

```
hello-nextjs/
├── src/
│   ├── app/           # Next.js app directory
│   └── components/    # React components
├── public/            # Static assets
├── .github/           # GitHub Actions workflows
└── vercel.json       # Vercel configuration
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Built with [Next.js](https://nextjs.org/)
- Deployed on [Vercel](https://vercel.com/)
- Styled with [Tailwind CSS](https://tailwindcss.com/)