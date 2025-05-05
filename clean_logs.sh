#!/bin/bash

# Script logfile
LOGFILE="/home/scriptadmin/scripts/logs/cleanup.log"

# Body of the script: clean up logs
{
echo "----------------------------------------------------------"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleaning up logs..."
sudo find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleanup completed successfully!"
} 2>&1 | tee -a "$LOGFILE"
