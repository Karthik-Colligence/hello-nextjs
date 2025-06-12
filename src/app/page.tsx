export default function Home() {
  return (
    <main className="flex-1 flex items-center justify-center">
      <div className="text-center px-4 py-8 sm:px-6 lg:px-8">
        <h1 className="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-600 to-pink-600 mb-8 animate-fade-in">
          Hello World from Next.js!
        </h1>
        <p className="text-lg sm:text-xl md:text-2xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto animate-fade-in-delay">
          Welcome to your beautiful Next.js application with TypeScript and Tailwind CSS
        </p>
      </div>
    </main>
  );
}