#!/usr/bin/env bash

# Reset
Color_Off=''

# Regular Colors
Red=''
Green=''
Dim='' # White

# Bold
Bold_White=''
Bold_Green=''

if [[ -t 1 ]]; then
    # Reset
    Color_Off='\033[0m' # Text Reset

    # Regular Colors
    Red='\033[0;31m'   # Red
    Green='\033[0;32m' # Green
    Dim='\033[0;2m'    # White

    # Bold
    Bold_Green='\033[1;32m' # Bold Green
    Bold_White='\033[1m'    # Bold White
fi

error() {
    echo -e "${Red}error${Color_Off}:" "$@" >&2
    exit 1
}

info() {
    echo -e "${Dim}$@ ${Color_Off}"
}

info_bold() {
    echo -e "${Bold_White}$@ ${Color_Off}"
}

success() {
    echo -e "${Green}$@ ${Color_Off}"
}

# Setups
get_file() {
    curl -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3.raw" \
        -LO https://api.github.com/repos/bentrynning/hosty/contents/$1
}

sudo apt-get install unzip

# Variables
hosty_zip="hosty.zip"
install_dir="/data/hosty"

# Create the install directory if it doesn't exist
if [[ ! -d $install_dir ]]; then
    mkdir -p "$install_dir" ||
        error "Error: Failed to create install directory \"$install_dir\""
fi

# Download the ZIP file
get_file "$hosty_zip" ||
    error "Error: Failed to download hosty from GitHub"

# Unzip the file into hosty dir
unzip -oq "$hosty_zip" -d "$install_dir" ||
    error "Error: Failed to extract hosty"


# Secure the pod
source /data/hosty/scripts/secure.sh

# Install docker
source /data/hosty/scripts/docker.sh

# Start up Hosty
source /data/hosty/scripts/start.sh

