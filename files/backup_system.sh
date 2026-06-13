#!/bin/bash
# ============================================
# TechHub Nightly Backup Script
# Location: /usr/local/bin/backup_system.sh
# Runs via cron: 0 2 * * * (every night at 2AM)
# ============================================

BACKUP_DIR="/var/backups/enterprise"
TARGET_SRC="/var/www"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="web_backup_$TIMESTAMP.tar.gz"
LOG_FILE="/var/log/backup_audit.log"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "[$(date)] Backup started." >> "$LOG_FILE"

# Compress the web directory into a timestamped archive
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$TARGET_SRC"

# Generate a SHA256 hash of the archive for integrity verification
# If someone tampers with the backup later, this hash won't match
HASH_VAL=$(sha256sum "$BACKUP_DIR/$ARCHIVE_NAME" | awk '{print $1}')
echo "[$(date)] Archive: $ARCHIVE_NAME | SHA256: $HASH_VAL" >> "$LOG_FILE"

echo "[$(date)] Backup completed successfully." >> "$LOG_FILE"
