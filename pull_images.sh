#!/bin/bash

GHCR_USER="TomasSerra"

GHCR_PAT="${GHCR_PAT}"

if [ -z "$GHCR_PAT" ]; then
  echo "Error: La variable de entorno GHCR_PAT no está definida."
  exit 1
fi

echo "Autenticando en ghcr.io..."
echo "$GHCR_PAT" | docker login ghcr.io -u "$GHCR_USER" --password-stdin

if [ $? -ne 0 ]; then
  echo "Error: No se pudo autenticar en GitHub Container Registry."
  exit 1
fi

echo "Haciendo docker-compose pull..."
docker compose pull snippet-manager permissions-manager printscript-service

if [ $? -ne 0 ]; then
  echo "Error: No se pudieron traer las imágenes."
  exit 1
fi

echo "Iniciando servicios con docker-compose up..."
docker compose up