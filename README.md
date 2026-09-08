# SentinelOps — Automated Server Backup & Monitoring System

A production-grade DevOps automation tool that handles server backups and system health monitoring using Linux Shell Scripting, Python Boto3, and AWS S3.

## Features
- Automated compressed backups with timestamps
- Auto-cleanup of old backups (retains last 3)
- Detailed logging of all operations
- System health monitoring (CPU, Memory, Disk alerts)
- AWS S3 cloud backup integration (CLI + Python Boto3)
- Error handling and validation
- Fully automated via cron jobs

## Tech Stack
- Linux (Ubuntu/WSL)
- Bash Shell Scripting
- Python 3 + Boto3
- AWS S3
- AWS CLI

## Project Structure
SentinelOps/

├── backups/      # Backup files stored here

├── config/       # Configuration files

├── logs/         # Operation logs

└── scripts/      # Shell scripts + Python scripts

## Usage of backup 
```bash
# Run backup script
bash scripts/backup.sh

# Run monitoring script
bash scripts/monitor.sh

# Run Python S3 upload
python3 scripts/s3_upload.py
```

## Author
Pratik — BCA 2nd Year | Sandip University
Cloud/DevOps Enthusiast
