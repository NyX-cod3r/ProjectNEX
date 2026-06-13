#!/bin/bash
# ============================================
# TechHub Service Health Monitor
# Location: /usr/local/bin/health_check.sh
# Runs via cron: */5 * * * * (every 5 minutes)
# ============================================

LOG_FILE="/var/log/service_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Services to monitor
SERVICES=("apache2" "bind9" "smbd")

# Loop through each service and check if it's running
for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "[$TIMESTAMP] OK: $service is running." >> "$LOG_FILE"
    else
        echo "[$TIMESTAMP] WARNING: $service is NOT WORKING!" >> "$LOG_FILE"
    fi
done
