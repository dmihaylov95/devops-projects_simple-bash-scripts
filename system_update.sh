#!/bin/bash

# Script logfile
LOGFILE="/home/scriptadmin/scripts/logs/update.log"

# Prompt user to proceed
read -p "Are you sure you want to install system updates? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted by user."
    exit 1
fi

# Body of the script: install updates and check if server needs reboot
{
echo "----------------------------------------------------------"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting system update..."
sudo dnf -y update
echo "[$(date '+%Y-%m-%d %H:%M:%S')] System update completed successfully!"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Checking if a reboot is required..."
if needs-restarting -r >/dev/null 2>&1; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] System does NOT require a reboot."
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] System requires a reboot to complete updates."
fi
} 2>&1 | tee -a "$LOGFILE"
