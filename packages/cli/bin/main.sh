#!/usr/bin/env bash

# Variables
REMOTE_USER="root"
REMOTE_HOST="hostii.dev"
REMOTE_PORT=22
LOCAL_SCRIPT_PATH=""

execute_script() {
    # Execute the script on the remote server using SSH 
    ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "bash -s" < $LOCAL_SCRIPT_PATH
}

if [[ $1 == "start" ]]; then
    LOCAL_SCRIPT_PATH="./terminal/start.sh"
    execute_script
fi
if [[ $1 == "setup" ]]; then
    # scp -r ./install $REMOTE_USER@$REMOTE_HOST:/
    LOCAL_SCRIPT_PATH="./terminal/setup.sh"
    execute_script
fi
if [[ $1 == "admin" ]]; then
    ssh -L 8080:localhost:8080 $REMOTE_USER@$REMOTE_HOST
fi
if [[ $1 == "deploy" ]]; then
    LOCAL_SCRIPT_PATH="./terminal/deploy.sh"
    execute_script
fi

if [[ $# -eq 0 ]]; then
    GREEN_BOLD="$(tput bold; tput setaf 2)"
    RESET="$(tput sgr0)"
    echo "${GREEN_BOLD}Welcome to Hosty CLI!${RESET}"
    echo "Usage: ./main.sh <command>"
    echo "" 
    echo "Available commands:"
    echo "  start   - Start the remote server application."
    echo "  setup   - Run the setup script on the remote server."
    echo "  admin   - Open an SSH tunnel for admin access (port 8080)."
    echo "  deploy  - Full install and start Hosty on a new VPS."
    echo ""
    echo "Example:"
    echo "  ./main.sh start"
    exit 0
fi

# the script on the remote server using SSH 
# ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "bash -s" < $REMOTE_SCRIPT_PATH
# Optional: If you want to execute the script locally and pass it to the remote server for execution
