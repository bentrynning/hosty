# Hosty CLI

A command-line interface for managing Hosty deployments on remote servers.

## Installation

### As an npm package (Recommended)

```bash
npm install -g @hosty/cli
```

After installation, the `hosty` command will be available globally:

```bash
hosty <command>
```

### Development/Local usage

```bash
./bin/main.sh <command>
```

## Usage

```bash
hosty <command>
```

Or if running locally:

```bash
./bin/main.sh <command>
```

## Commands

- **`start`** - Start the Hosty application on the remote server
- **`setup`** - Run the initial setup script on the remote server  
- **`admin`** - Open an SSH tunnel for admin access (port 8080)
- **`deploy`** - Full deployment: setup and start Hosty on a new VPS

## Configuration

The CLI connects to remote servers via SSH. You can configure the connection using environment variables:

```bash
export HOSTY_REMOTE_USER=root           # Default: root
export HOSTY_REMOTE_HOST=your-server.com # Default: blog.hosty.sh  
export HOSTY_REMOTE_PORT=22             # Default: 22
```

## Prerequisites

### Local Machine
- SSH access to the remote server
- `GITHUB_TOKEN` environment variable set (for `start` and `deploy` commands)

### Remote Server
- Ubuntu/Debian-based Linux system
- SSH server running
- sudo access for the connecting user

## Examples

```bash
# Start Hosty on the default server (after npm install -g @hosty/cli)
export GITHUB_TOKEN=your_token_here
hosty start

# Deploy to a custom server
export GITHUB_TOKEN=your_token_here
export HOSTY_REMOTE_HOST=my-server.com
hosty deploy

# Open admin tunnel
hosty admin

# Local development usage
export GITHUB_TOKEN=your_token_here
./bin/main.sh start
```

## How It Works

The CLI scripts work by:

1. **SSH Connection**: Connecting to the remote server via SSH
2. **Script Transfer**: Transferring and executing bash scripts on the remote server
3. **Environment Variables**: Passing necessary environment variables (like `GITHUB_TOKEN`) to the remote scripts
4. **Docker Operations**: Running Docker commands on the remote server to manage Hosty containers

The remote scripts handle:

- Downloading the latest Hosty engine package
- Setting up Docker and security configurations  
- Starting/stopping Hosty services
- Managing Docker registry authentication

## Security Notes

- Ensure your remote server has proper SSH key authentication set up
- The `GITHUB_TOKEN` is only used for Docker registry authentication and is not stored on the remote server
- The setup script includes security hardening for the remote server
