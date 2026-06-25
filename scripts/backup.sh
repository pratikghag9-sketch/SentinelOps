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

# --- Pre-flight Checks ---
if [ ! -d "$SOURCE_DIR" ]; then
  echo "[$TIMESTAMP] ERROR: Source directory not found: $SOURCE_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
  echo "[$TIMESTAMP] ERROR: Backup directory not found: $BACKUP_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

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

# --- S3 Upload ---
S3_BUCKET="s3://sentinelops-backup-pratik"
echo "[$TIMESTAMP] Uploading backup to S3..." | tee -a "$LOG_FILE"
aws s3 cp "$BACKUP_DIR/$BACKUP_NAME" "$S3_BUCKET/"
if [ $? -eq 0 ]; then
  echo "[$TIMESTAMP] Upload successful: $BACKUP_NAME" | tee -a "$LOG_FILE"
else
  echo "[$TIMESTAMP] ERROR: Upload failed!" | tee -a "$LOG_FILE"
fi
