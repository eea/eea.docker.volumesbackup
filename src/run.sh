#!/bin/bash

if [ -z "$SCHEDULE" ]; then
  /bin/backup.sh; exit $?
fi

touch /backup/scheduled-backup.log
echo "$SCHEDULE root /bin/backup.sh >> /backup/scheduled-backup.log 2>&1" > /etc/cron.d/cronjob

cron && tail -f /backup/scheduled-backup.log
