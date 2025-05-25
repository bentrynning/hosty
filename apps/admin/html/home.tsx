import { Layout } from "./layout";

// Read the SVG at build/startup time
const copySvg = Bun.file(
  "../../node_modules/lucide-static/icons/copy.svg"
).text();

export async function Home() {
  return (
    <Layout>
      <h1 className="text-5xl md:text-6xl font-extrabold text-white mb-6 text-center drop-shadow-lg tracking-tight">
        Welcome to Hosty
      </h1>
      <p className="text-xl md:text-2xl text-gray-300 mb-8 text-center max-w-xl">
        Super simple, super fast hosting. Deploy in seconds with a single
        command.
      </p>
      <div className="w-full flex flex-col items-center">
        <div className="bg-[#23243a] border border-[#2d2e4a] rounded-xl shadow-lg px-6 py-5 mb-4 w-full max-w-xl flex flex-col items-center">
          <div className="flex items-center justify-center w-full">
            <span className="text-[#7ee787] font-mono text-base select-none mr-2">
              $
            </span>
            <code
              id="install-script"
              className="text-[#7ee787] font-mono text-base whitespace-nowrap select-all text-center border-none p-0"
            >
              curl -fsSL https://hosty.sh/install.sh | sh
            </code>
            <span
              id="copy-install"
              className="w-6 h-6 flex ml-6 items-center cursor-pointer p-1 rounded hover:bg-[#2d2e4a] text-[#60aaff]"
              title="Copy to clipboard"
              dangerouslySetInnerHTML={{ __html: await copySvg }}
            />
          </div>
        </div>
        <a
          href="/install"
          className="mt-2 text-[#60aaff] hover:underline text-sm text-center font-medium"
        >
          View install script
        </a>
      </div>
    </Layout>
  );
}
