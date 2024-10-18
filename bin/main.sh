#!/bin/bash

# Variables
REMOTE_USER="root"
REMOTE_HOST="165.232.77.93"
REMOTE_PORT=22
LOCAL_SCRIPT_PATH="./deploy.sh"

# Execute the script on the remote server using SSH 
# ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "bash -s" < $REMOTE_SCRIPT_PATH

# Optional: If you want to execute the script locally and pass it to the remote server for execution
 ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "TOKEN=$TOKEN bash -s" < $LOCAL_SCRIPT_PATH