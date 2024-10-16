#!/bin/bash

source ~/.bashrc

GHCR_USER="TomasSerra"

GHCR_PAT="${GHCR_PAT}"

if [ -z "$GHCR_PAT" ]; then
  echo "Error: The GHCR_PAT environment variable is required."
  exit 1
fi

echo "Autenticating in ghcr.io..."
echo "$GHCR_PAT" | docker login ghcr.io -u "$GHCR_USER" --password-stdin

if [ $? -ne 0 ]; then
  echo "Error: Can not authenticate in ghcr.io."
  exit 1
fi

echo "Docker-compose pull..."
docker compose pull snippet-manager permission-manager printscript-service

if [ $? -ne 0 ]; then
  echo "Error: Can not pull images."
  exit 1
fi

docker compose up -d