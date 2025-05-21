#!/bin/bash
# disk_alert.sh
# Alerts if disk usage exceeds threshold

THRESHOLD=80
EMAIL="admin@example.com"
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output; do
  usep=$(echo $output | awk '{ print $1}' | sed 's/%//')
  partition=$(echo $output | awk '{ print $2 }')
  if [ $usep -ge $THRESHOLD ]; then
    echo "Running out of space $partition ($usep%)" | \
    mail -s "Disk Space Alert: $partition at $usep%" $EMAIL
  fi
done
