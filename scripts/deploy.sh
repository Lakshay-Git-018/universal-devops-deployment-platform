#!/bin/bash

set -e

APP_NAME="learnhub"
IMAGE_NAME="learnhub:latest"
PORT="8080"

echo "Starting LearnHub deployment..."

echo "Building Docker image..."
docker build -f docker/Dockerfile -t "$IMAGE_NAME" .

echo "Removing old container if it exists..."
docker rm -f "$APP_NAME" 2>/dev/null || true

echo "Starting new container..."
docker run -d \
  --name "$APP_NAME" \
  -p "$PORT:80" \
  --restart unless-stopped \
  "$IMAGE_NAME"

echo "Checking application..."
sleep 3

if curl -fsS "http://localhost:$PORT/" > /dev/null; then
    echo "SUCCESS: LearnHub deployed successfully!"
else
    echo "ERROR: Deployment health check failed."
    exit 1
fi
