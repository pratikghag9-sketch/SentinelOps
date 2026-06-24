#!/bin/bash

# ============================================
# SentinelOps - Monitoring Script
# Author: Pratik
# Description: Monitors CPU, Memory, Disk, and Processes
# ============================================

# --- Configuration ---
LOG_FILE="/home/pratik04/SentinelOps/logs/monitor.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

echo "[$TIMESTAMP] Starting system health check..." | tee -a "$LOG_FILE"

# --- CPU Check ---
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "[$TIMESTAMP] CPU Usage: $CPU_USAGE%" | tee -a "$LOG_FILE"
if [ $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc) -eq 1 ]; then
  echo "[$TIMESTAMP] WARNING: CPU usage high: $CPU_USAGE%" | tee -a "$LOG_FILE"
fi

# --- Memory Check ---
MEMORY_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
echo "[$TIMESTAMP] Memory Usage: $MEMORY_USAGE%" | tee -a "$LOG_FILE"
if [ $MEMORY_USAGE -gt $MEMORY_THRESHOLD ]; then
  echo "[$TIMESTAMP] WARNING: Memory usage high: $MEMORY_USAGE%" | tee -a "$LOG_FILE"
fi

# --- Disk Check ---
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
echo "[$TIMESTAMP] Disk Usage: $DISK_USAGE%" | tee -a "$LOG_FILE"
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
  echo "[$TIMESTAMP] WARNING: Disk usage high: $DISK_USAGE%" | tee -a "$LOG_FILE"
fi

echo "[$TIMESTAMP] Health check complete." | tee -a "$LOG_FILE"




