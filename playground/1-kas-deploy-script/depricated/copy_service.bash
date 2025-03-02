#!/bin/bash

# Load environment variables from .env file
CURR_DIR="$(realpath $(dirname ${BASH_SOURCE[0]}))"
source "$CURR_DIR/.env"

# Check if a file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <service-file-path>"
    exit 1
fi

service_file="$1"
service_name=$(basename "$service_file")
tmp_service_file="/tmp/$service_name"

# Check if the file exists
if [ ! -f "$service_file" ]; then
    echo "Error: File '$service_file' not found."
    exit 1
fi

# Replace placeholders with environment variables
export $(grep -v '^#' "$CURR_DIR/.env" | xargs) # Ensure env variables are available
envsubst < "$service_file" > "$tmp_service_file"

# Copy to systemd directory
sudo cp "$tmp_service_file" "/etc/systemd/system/$service_name"

# Set correct permissions
sudo chmod 644 "/etc/systemd/system/$service_name"

# Cleanup temporary file
rm "$tmp_service_file"

echo "Service file copied successfully to /etc/systemd/system/$service_name."
