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

# Start up Hosty
info "Starting Hosty on remote server..."

# Check if GITHUB_TOKEN is set
if [[ -z "$GITHUB_TOKEN" ]]; then
    error "GITHUB_TOKEN environment variable is not set"
fi

info "Logging into Docker registry..."
echo "$GITHUB_TOKEN" | docker login ghcr.io -u bentrynning --password-stdin

# Check if engine directory exists, if not use data directory

ENGINE_DIR="./engine"
if [[ ! -d "$ENGINE_DIR" ]]; then
    error "Engine directory not found. Please run 'hosty setup' first."
fi

info "Changing to engine directory: $ENGINE_DIR"
cd "$ENGINE_DIR" || error "Failed to change to engine directory"

info "Starting Docker containers..."
docker compose up -d || error "Failed to start Docker containers"

info "Cleaning up Docker configuration..."
rm -f ~/.docker/config.json

success "Hosty started successfully! 🚀"
