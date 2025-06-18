# hosty

To install dependencies:

```bash
bun install
```

To run:

```bash
bun run index.ts
```

To install Hosty on a new VPS in one command:

```sh
curl -fsSL https://raw.githubusercontent.com/bentrynning/hosty/main/packages/cli/bin/boot.sh | bash
```

Or, install the Hosty CLI and manage remotely:

```sh
npm install -g @hosty/cli
export GITHUB_TOKEN=your_token_here
hosty deploy
```

For local development, use the CLI directly:

```sh
./packages/cli/bin/main.sh deploy
```

This project was created using `bun init` in bun v1.1.30. [Bun](https://bun.sh) is a fast all-in-one JavaScript runtime.
