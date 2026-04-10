#!/bin/bash
# Order Management System - Startup Script
# Single HTML file served via npx serve

set -e

# Source shell profile for environment variables
if [ -f ~/.zshrc ]; then
  source ~/.zshrc 2>/dev/null || true
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PORT="${PORT:-3000}"

# Kill any existing serve process on the port
lsof -ti:$PORT 2>/dev/null | xargs kill -9 2>/dev/null || true

echo "Starting Order Management System on port $PORT..."
echo "Project directory: $PROJECT_DIR"

# Create log directory
mkdir -p "$SCRIPT_DIR"

# Start static file server
cd "$PROJECT_DIR"
npx -y serve -s . -p $PORT > "$SCRIPT_DIR/frontend.log" 2>&1 &
SERVER_PID=$!

echo "Server PID: $SERVER_PID"

# Wait for server to be ready
for i in $(seq 1 15); do
  if curl -s "http://localhost:$PORT" > /dev/null 2>&1; then
    echo "✓ Server is running at http://localhost:$PORT"
    exit 0
  fi
  sleep 1
done

echo "✗ Server failed to start. Check $SCRIPT_DIR/frontend.log"
cat "$SCRIPT_DIR/frontend.log"
exit 1
