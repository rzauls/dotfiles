#!/bin/bash

# Backup script for syncing Dropbox to external drive using rclone
# Usage: ./sync_dropbox.sh [-r remote_name] [-p remote_path] [-t target_dir]
# Options:
#   -r  Remote name (default: dropbox)
#   -p  Remote path to sync (default: root)
#   -t  Target directory (default: script directory)
#   -h  Show this help message
# Examples:
#   ./sync_dropbox.sh                           # sync dropbox root to script dir
#   ./sync_dropbox.sh -p /Documents             # sync /Documents to script dir
#   ./sync_dropbox.sh -t /Volumes/backup        # sync dropbox root to custom dir
#   ./sync_dropbox.sh -r mydropbox -p /Photos -t /Volumes/backup

set -e

# Configuration defaults
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REMOTE_NAME="dropbox"
REMOTE_PATH=""
TARGET_DIR="$SCRIPT_DIR"

# Parse flags
show_help() {
    sed -n '2,12p' "$0" | sed 's/^# //'
    exit 0
}

while getopts "r:p:t:h" opt; do
    case $opt in
        r) REMOTE_NAME="$OPTARG" ;;
        p) REMOTE_PATH="$OPTARG" ;;
        t) TARGET_DIR="$OPTARG" ;;
        h) show_help ;;
        *) show_help ;;
    esac
done

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
    echo -e "${GREEN}Syncing entire ${REMOTE_NAME} to ${TARGET_DIR}${NC}"
else
    SOURCE="${REMOTE_NAME}:${REMOTE_PATH}"
    echo -e "${GREEN}Syncing ${REMOTE_NAME}:${REMOTE_PATH} to ${TARGET_DIR}${NC}"
fi

# Confirmation prompt
echo ""
echo "This will sync from:"
echo "  Source: ${SOURCE}"
echo "  Destination: ${TARGET_DIR}"
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

rclone sync "$SOURCE" "$TARGET_DIR" \
    --progress \
    --verbose \
    --transfers 4 \
    --checkers 8 \
    --contimeout 60s \
    --timeout 300s \
    --retries 3 \
    --low-level-retries 10 \
    --stats 1s \
    --exclude "._*"

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
