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

# Execute the script on the remote server using SSH 
# ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "bash -s" < $REMOTE_SCRIPT_PATH
# Optional: If you want to execute the script locally and pass it to the remote server for execution
