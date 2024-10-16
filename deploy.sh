#!/usr/bin/env bash

get_file() {
    curl -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3.raw" \
        -LO https://api.github.com/repos/bentrynning/hosty/contents/$1
}

# Variables
hosty_zip="hosty.zip"
install_dir="/data/hosty"

# Download the ZIP file
get_file "$hosty_zip" ||
    error "Error: Failed to download hosty from GitHub"

# Unzip the file into hosty dir
unzip -oq "$hosty_zip" -d "$install_dir" ||
    error "Error: Failed to extract hosty"


# Start up Hosty
source /data/hosty/scripts/start.sh