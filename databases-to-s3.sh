#!/bin/bash

# Get the current date and time in yyyy-mm-dd-hh-mm-ss format
completedate=$(date +'%Y-%m-%d-%H-%M-%S')

# Get a list of all databases on the Plesk instance
databases=$(plesk db -Ne "show databases")

# AWS S3 bucket name
s3_bucket="-plesk-sql-backups"

# Loop through each database and perform the backup
for dbname in $databases; do
   # Log the current date and time
   echo "Script started at: $completedate"

   # Log the action being taken
   echo "Running backup for database: $dbname"

   # Run the command to back up the current database
   echo "Executing: plesk db dump $dbname --skip-extended-insert > /var/www/vhosts/sqlbackups/$dbname-$completedate.sql"
   plesk db dump "$dbname" --skip-extended-insert > /var/www/vhosts/sqlbackups/$dbname-$completedate.sql

   # Log the completion message
   echo "Backup for database $dbname completed"

   # Sync the backup to AWS S3
   echo "Syncing backup to AWS S3..."
   aws s3 cp /var/www/vhosts/sqlbackups/$dbname-$completedate.sql s3://$s3_bucket/sqlbackups/$dbname/

   # Log the S3 sync status
   echo "Sync to AWS S3 completed"

   # Delete the local backup file
   echo "Deleting local backup file..."
   rm -f /var/www/vhosts/sqlbackups/$dbname-$completedate.sql

   # Log the file deletion status
   echo "Local backup file deleted"
done

# Log the end of the script
echo "Script completed."

