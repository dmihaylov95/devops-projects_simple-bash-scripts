#!/bin/bash

# Script logfile
LOGFILE="/home/scriptadmin/scripts/logs/backup.log"

# Ask user for directories to back up
echo "Please enter the directories you want to back up, separated by spaces:"
read -p "Directories: " -a BACKUP_SOURCES

# Check if any directories were provided
if [ ${#BACKUP_SOURCES[@]} -eq 0 ]; then
    echo "No directories provided. Exiting..."
    exit 1
fi

# Backup destination
BACKUP_DIR="/home/scriptadmin/scripts/backups"

# Date format and backup file format
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Body of the script: create backup file and check if it was created successfully
{
    echo "----------------------------------------"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting backup..."
    echo "Backing up: ${BACKUP_SOURCES[*]}"
    echo "Backup file: $BACKUP_FILE"
    sudo tar -czf "$BACKUP_FILE" "${BACKUP_SOURCES[@]}"
    TAR_EXIT=$?
    if [[ $TAR_EXIT -eq 0 ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully."
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup failed with exit code $TAR_EXIT."
    fi
} 2>&1 | tee -a "$LOGFILE"
