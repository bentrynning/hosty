#!/bin/bash
# install.sh: Download and install the Hosty engine package from a release asset

set -e

ARCHIVE_URL="https://github.com/bentrynning/hosty/releases/latest/download/engine-latest.tar.gz"
ARCHIVE_NAME="engine-latest.tar.gz"
ENGINE_DIR="engine"

# Download the engine package
if [ ! -f "$ARCHIVE_NAME" ]; then
  echo "Downloading engine package..."
  curl -L -o "$ARCHIVE_NAME" "$ARCHIVE_URL"
else
  echo "Archive already downloaded."
fi

# Extract the engine package
if [ ! -d "$ENGINE_DIR" ]; then
  echo "Extracting engine package..."
  tar -xzf "$ARCHIVE_NAME"
else
  echo "Engine directory already exists."
fi

cd "$ENGINE_DIR/scripts" || { echo "Failed to enter scripts directory."; exit 1; }

echo "Running setup.sh..."
chmod +x setup.sh
./setup.sh

echo "Engine setup complete!"
