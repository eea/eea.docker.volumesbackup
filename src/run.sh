#!/bin/bash

if [ -z "$SCHEDULE" ]; then
  /bin/backup.sh; exit $?
fi

touch /var/log/volumesbackup.log
echo "$SCHEDULE root /bin/backup.sh >> /var/log/volumesbackup.log 2>&1" > /etc/cron.d/cronjob

cron && tail -f /var/log/volumesbackup.log
