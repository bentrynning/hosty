#!/usr/bin/env bash

# Get the directory where this script is located, resolving any symlinks
# This handles cases where the script is called via a symlink (e.g., global npm install)
SCRIPT_PATH="${BASH_SOURCE[0]}"
while [ -L "$SCRIPT_PATH" ]; do
    SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_PATH")" && pwd)"
    SCRIPT_PATH="$(readlink "$SCRIPT_PATH")"
    [[ $SCRIPT_PATH != /* ]] && SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_PATH"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_PATH")" && pwd)"

# When installed as npm package, the structure is:
# node_modules/@hosty/cli/bin/main.sh
# node_modules/@hosty/cli/terminal/*.sh
#
# When in development, the structure is:
# packages/cli/bin/main.sh  
# packages/cli/terminal/*.sh
#
# So we need to find the terminal directory relative to this script
if [[ -d "$SCRIPT_DIR/../terminal" ]]; then
    # Development or direct installation structure
    TERMINAL_DIR="$SCRIPT_DIR/../terminal"
elif [[ -d "$SCRIPT_DIR/../../terminal" ]]; then
    # Alternative structure
    TERMINAL_DIR="$SCRIPT_DIR/../../terminal"
else
    # Try to find it in the package directory
    PACKAGE_DIR="$(dirname "$SCRIPT_DIR")"
    if [[ -d "$PACKAGE_DIR/terminal" ]]; then
        TERMINAL_DIR="$PACKAGE_DIR/terminal"
    else
        echo "Error: Could not locate terminal scripts directory"
        exit 1
    fi
fi

# Remote server configuration
# These can be overridden by environment variables
REMOTE_USER="${HOSTY_REMOTE_USER:-root}"
REMOTE_HOST="${HOSTY_REMOTE_HOST:-blog.hosty.sh}"
REMOTE_PORT="${HOSTY_REMOTE_PORT:-22}"
LOCAL_SCRIPT_PATH=""

execute_script() {
    local command="$1"
    
    # Check if the script file exists
    if [[ ! -f "$LOCAL_SCRIPT_PATH" ]]; then
        echo "Error: Script not found at $LOCAL_SCRIPT_PATH"
        exit 1
    fi
    
    # Check if required environment variables are set for certain commands
    if [[ "$command" == "start" || "$command" == "deploy" ]]; then
        if [[ -z "$GITHUB_TOKEN" ]]; then
            echo "Error: GITHUB_TOKEN environment variable is required for this command"
            echo "Please set GITHUB_TOKEN and try again:"
            echo "  export GITHUB_TOKEN=your_token_here"
            exit 1
        fi
    fi
    
    # Execute the script on the remote server using SSH with environment variables
    ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "GITHUB_TOKEN='$GITHUB_TOKEN' bash -s" < $LOCAL_SCRIPT_PATH
}

if [[ $1 == "start" ]]; then
    echo "🚀 Starting Hosty on remote server $REMOTE_HOST..."
    LOCAL_SCRIPT_PATH="$TERMINAL_DIR/start.sh"
    execute_script "start"
fi
if [[ $1 == "setup" ]]; then
    echo "⚙️  Setting up Hosty on remote server $REMOTE_HOST..."
    LOCAL_SCRIPT_PATH="$TERMINAL_DIR/setup.sh"
    execute_script "setup"
fi
if [[ $1 == "admin" ]]; then
    echo "🔧 Opening SSH tunnel for admin access to $REMOTE_HOST:8080..."
    ssh -L 8080:localhost:8080 $REMOTE_USER@$REMOTE_HOST
fi
if [[ $1 == "deploy" ]]; then
    echo "🚀 Deploying Hosty to remote server $REMOTE_HOST..."
    LOCAL_SCRIPT_PATH="$TERMINAL_DIR/deploy.sh"
    execute_script "deploy"
fi
if [[ $1 == "debug" ]]; then
    echo "Debug Information:"
    echo "  Script directory: $SCRIPT_DIR"
    echo "  Terminal directory: $TERMINAL_DIR"
    echo "  Available terminal scripts:"
    ls -la "$TERMINAL_DIR"/ 2>/dev/null || echo "    (terminal directory not found)"
    exit 0
fi

if [[ $# -eq 0 ]]; then
    GREEN_BOLD="$(tput bold; tput setaf 2)"
    BLUE_BOLD="$(tput bold; tput setaf 4)"
    RESET="$(tput sgr0)"
    
    # Determine command name based on how the script was called
    COMMAND_NAME="$(basename "$0")"
    if [[ "$COMMAND_NAME" == "main.sh" ]]; then
        COMMAND_NAME="./main.sh"
    fi
    
    echo "${GREEN_BOLD}Welcome to Hosty CLI!${RESET}"
    echo "Usage: $COMMAND_NAME <command>"
    echo "" 
    echo "Available commands:"
    echo "  start   - Start the remote server application."
    echo "  setup   - Run the setup script on the remote server."
    echo "  admin   - Open an SSH tunnel for admin access (port 8080)."
    echo "  deploy  - Full install and start Hosty on a new VPS."
    echo "  debug   - Show debug information about script paths."
    echo ""
    echo "Configuration:"
    echo "  Current remote server: ${BLUE_BOLD}${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PORT}${RESET}"
    echo ""
    echo "  You can customize the remote server by setting environment variables:"
    echo "    HOSTY_REMOTE_USER (default: root)"
    echo "    HOSTY_REMOTE_HOST (default: blog.hosty.sh)"
    echo "    HOSTY_REMOTE_PORT (default: 22)"
    echo ""
    echo "Example:"
    echo "  $COMMAND_NAME start"
    echo "  HOSTY_REMOTE_HOST=my-server.com $COMMAND_NAME deploy"
    exit 0
fi