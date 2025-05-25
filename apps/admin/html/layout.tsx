import type { FC } from "hono/jsx";

export const Layout: FC = (props) => {
  return (
    <html lang="en">
      <head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Hosty - Fast, Modern Hosting</title>
        <link href="/static/styles.css" rel="stylesheet" />
        <script src="/static/copy.js"></script>
      </head>
      <body className="bg-gradient-to-br from-[#18181b] via-[#23243a] to-[#1a2238] min-h-screen flex flex-col items-center justify-center px-4">
       <main className="flex flex-col items-center justify-center w-full max-w-2xl py-16">
        {props.children}
        <footer className="text-gray-500 text-xs mt-12">
          &copy; {new Date().getFullYear()} Hosty.
        </footer>
       </main>
      </body>
    </html>
  );
}
