import app from "../static.tsx";
import { writeFileSync, mkdirSync,  } from "fs";

// Define your routes and output paths
const pages = [
  { path: "/", out: "./static/index.html" },
  // { path: "/about", out: path.join(DOCS_DIR, "about/index.html") },
  // { path: "/contact", out: path.join(DOCS_DIR, "contact/index.html") }
];

async function build() {
  for (const page of pages) {
    const res = await app.request(page.path);
    const html = await res.text();

    // Ensure the directory exists
    // mkdirSync(page.out, { recursive: true });
    writeFileSync(page.out, html);
    console.log(`Generated ${page.out}`);
  }
}

build();