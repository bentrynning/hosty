import { Hono } from "hono";
import { serveStatic } from "hono/bun";
import { Home } from "./html/home";

const app = new Hono();

app.get("/health", (c) => c.text("Hello, Hono!"));

app.use("/static/*", serveStatic({ root: "./" }));

app.get("/install", serveStatic({ path: "./static/install.sh" }));

app.get("/", async (c) =>
  c.html(<Home />)
);

// Start the Hono app as usual
Bun.serve({
  port: 3000,
  fetch: app.fetch,
});

export default app;

console.log("Server is running on http://localhost:3000");
