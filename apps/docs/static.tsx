import { Hono } from "hono";
import { Home } from "./html/home";

const app = new Hono();

app.get("/", async (c) =>
  c.html(<Home />)
);

export default app;

console.log("Static files are generated");
