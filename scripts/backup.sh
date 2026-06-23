#!/bin/bash


#--------------------------------------------------------------
#SentinelOps - Backup Script
#Author : Pratik 
#Description : Creates compressed backup of target directoey
#--------------------------------------------------------------


#--- Configuration ---
 
SOURCE_DIR="/home/pratik04/SentinelOps"
BACKUP_DIR="/home/pratik04/SentinelOps/backups"
LOG_FILE="/home/pratik04/SentinelOps/logs/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

#--- Create Backup ---

echo "[$TIMESTAMP] Starting backup..." | tee -a "$LOG_FILE"

tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

echo "[$TIMESTAMP] Backup created: $BACKUP_NAME" | tee -a "$LOG_FILE"

#--- Cleanup OLd Backup ---

KEEP=3
backup_count=$(ls -t "$BACKUP_DIR" | wc -l)

while [ $backup_count -gt $KEEP ]
do
	oldest=$(ls -t "$BACKUP_DIR" | tail -1)
	echo "[$TIMESTAMP] Deleting old backup: $oldest" | tee -a "$LOG_FILE"
	rm "$BACKUP_DIR/$oldest"
	backup_count=$(ls -t "$BACKUP_DIR" | wc -l)
done

echo "[$TIMESTAMP] Cleanup done.. $backup_count backups retained." | tee -a "$LOG_FILE"
