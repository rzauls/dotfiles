#!/bin/bash

# Backup script for syncing Dropbox to external drive using rclone
# Usage: ./sync_dropbox.sh [remote_name] [remote_path]
# Example: ./sync_dropbox.sh dropbox /path/to/folder
# Example: ./sync_dropbox.sh (uses "dropbox" as remote and syncs root)

set -e

# Configuration
REMOTE_NAME="${1:-dropbox}"
REMOTE_PATH="${2:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if rclone is installed
if ! command -v rclone &> /dev/null; then
    echo -e "${RED}Error: rclone is not installed${NC}"
    echo "Please install rclone first:"
    echo "  macOS: brew install rclone"
    echo "  Windows: choco install rclone (or download from rclone.org)"
    echo "  Linux: sudo apt install rclone (or download from rclone.org)"
    exit 1
fi

# Check if remote exists
if ! rclone listremotes | grep -q "^${REMOTE_NAME}:$"; then
    echo -e "${RED}Error: Remote '${REMOTE_NAME}' not found${NC}"
    echo "Available remotes:"
    rclone listremotes
    echo ""
    echo "To configure a remote, run: rclone config"
    exit 1
fi

# Build the source path
if [ -z "$REMOTE_PATH" ]; then
    SOURCE="${REMOTE_NAME}:"
    echo -e "${GREEN}Syncing entire ${REMOTE_NAME} to ${SCRIPT_DIR}${NC}"
else
    SOURCE="${REMOTE_NAME}:${REMOTE_PATH}"
    echo -e "${GREEN}Syncing ${REMOTE_NAME}:${REMOTE_PATH} to ${SCRIPT_DIR}${NC}"
fi

# Confirmation prompt
echo ""
echo "This will sync from:"
echo "  Source: ${SOURCE}"
echo "  Destination: ${SCRIPT_DIR}"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Sync cancelled"
    exit 0
fi

# Run the sync
echo -e "${YELLOW}Starting sync...${NC}"
echo ""

rclone sync "$SOURCE" "$SCRIPT_DIR" \
    --progress \
    --verbose \
    --transfers 4 \
    --checkers 8 \
    --contimeout 60s \
    --timeout 300s \
    --retries 3 \
    --low-level-retries 10 \
    --stats 1s

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
