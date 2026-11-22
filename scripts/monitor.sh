#!/bin/bash

APP_NAME="learnhub"
APP_URL="http://localhost:8080"
LOG_FILE="logs/monitoring.log"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "=================================="
echo " LearnHub Application Monitoring"
echo "=================================="
echo "Time: $TIMESTAMP"

# Check Docker container status
CONTAINER_STATUS=$(docker inspect \
  --format='{{.State.Status}}' "$APP_NAME" 2>/dev/null || echo "not_found")

if [ "$CONTAINER_STATUS" = "running" ]; then
    DOCKER_STATUS="RUNNING"
else
    DOCKER_STATUS="NOT RUNNING"
fi

# Check website HTTP response
HTTP_CODE=$(curl -s -o /dev/null \
  -w "%{http_code}" --max-time 5 "$APP_URL"  2>/dev/null)
if [ -z "$HTTP_CODE" ]; then
    HTTP_CODE="000"
fi
if [ "$HTTP_CODE" = "200" ]; then
    WEBSITE_STATUS="ONLINE"
else
    WEBSITE_STATUS="OFFLINE"
fi

# Display monitoring results
echo "Container Status: $DOCKER_STATUS"
echo "Website Status: $WEBSITE_STATUS"
echo "HTTP Response: $HTTP_CODE"

# Save results to log file
echo "$TIMESTAMP | Container: $DOCKER_STATUS | Website: $WEBSITE_STATUS | HTTP: $HTTP_CODE" >> "$LOG_FILE"

echo "Monitoring results saved."
echo "=================================="
