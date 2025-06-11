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
get_tar_package() {
    curl -L "https://api.github.com/repos/bentrynning/hosty/tarball/main" -o "$1" ||
    error "Error: Failed to download tar package from GitHub"
}

sudo apt-get install tar

# Variables
hosty_tar="hosty.tar.gz"
install_dir="/data/hosty"

# Create the install directory if it doesn't exist
if [[ ! -d $install_dir ]]; then
    mkdir -p "$install_dir" ||
        error "Error: Failed to create install directory \"$install_dir\""
fi

# Download the tar package
info "Downloading hosty engine from GitHub..."
get_tar_package "$hosty_tar" ||
    error "Error: Failed to download hosty from GitHub"

# Extract the tar package into hosty dir
info "Extracting hosty engine..."
tar -xzf "$hosty_tar" -C "$install_dir" --strip-components=1 ||
    error "Error: Failed to extract hosty"

# Clean up the downloaded tar file
rm -f "$hosty_tar"

source /data/hosty/scripts/setup.sh
