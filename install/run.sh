#!/usr/bin/env bash

# Install docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install docker compose
sudo apt-get install -y docker-compose

GITHUB=${GITHUB-"https://github.com"}

hosty_uri="$GITHUB/bentrynning/hosty/blob/main/install/run.sh"

install_dir=$HOME/hosty
exe=$install_dir/setup

if [[ ! -d $install_dir ]]; then
    mkdir -p "$install_dir" ||
        error "Failed to create install directory \"$install_dir\""
fi

curl --fail --location --progress-bar --output "$exe.zip" "$hosty_uri" ||
    error "Failed to download bun from \"$bun_uri\""

unzip -oqd "$install_dir" "$exe.zip" ||
    error 'Failed to extract bun'

# Start docker 
docker compose up -d