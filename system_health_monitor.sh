#!/bin/bash

# Configuration
LOG_FILE="/var/log/system_health.log"
MONITOR_DURATION=600  # in seconds (e.g., 10 minutes)
INTERVAL=60           # in seconds (e.g., 1 minute)

# Function to log system health
log_system_health() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP - CPU Usage: $CPU_USAGE%, Memory Usage: $MEMORY_USAGE%" >> $LOG_FILE
}

# Ensure log file exists and is writable
touch $LOG_FILE
chmod 666 $LOG_FILE

# Monitor system health for the specified duration
for ((i=0; i<$MONITOR_DURATION; i+=INTERVAL)); do
    log_system_health
    sleep $INTERVAL
done

echo "System health monitoring completed. Logs saved in $LOG_FILE."
