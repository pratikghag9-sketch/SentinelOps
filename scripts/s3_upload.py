#!/usr/bin/env python3

# ============================================
# SentinelOps - S3 Upload Script (Python/Boto3)
# Author: Pratik
# Description: Uploads latest backup to AWS S3
# ============================================

import boto3
import os
import glob
import logging
from datetime import datetime

# --- Configuration ---
BACKUP_DIR = "/home/pratik04/SentinelOps/backups"
S3_BUCKET = "sentinelops-backup-pratik"
LOG_FILE = "/home/pratik04/SentinelOps/logs/s3_upload.log"

# --- Logging Setup ---
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format="[%(asctime)s] %(message)s",
    datefmt="%Y-%m-%d_%H-%M-%S"
)

# --- Find Latest Backup ---
backups = glob.glob(f"{BACKUP_DIR}/*.tar.gz")

if not backups:
    logging.error("No backup files found!")
    print("ERROR: No backup files found!")
    exit(1)

latest_backup = max(backups, key=os.path.getctime)
filename = os.path.basename(latest_backup)

# --- Upload to S3 ---
try:
    s3 = boto3.client("s3")
    print(f"Uploading {filename} to S3...")
    s3.upload_file(latest_backup, S3_BUCKET, filename)
    logging.info(f"Upload successful: {filename}")
    print(f"Upload successful: {filename}")

except Exception as e:
    logging.error(f"Upload failed: {e}")
    print(f"ERROR: Upload failed: {e}")
    exit(1)
