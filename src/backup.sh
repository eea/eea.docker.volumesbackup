#!/bin/bash

echo ""
echo `date` " - Backup started"
echo "*************************************************************************"
echo ""

dockerver=$(/usr/sbin/chroot /rootfs docker -v | gawk '{print $3}' | sed 's/,//g')

if [[ $dockerver == 1.5* ]] || [[ $dockerver == 1.6* ]]; then
  voldir="/var/lib/docker/vfs/dir/"
else
  voldir="/var/lib/docker/volumes/"
fi

cd /backup;
ls $voldir > dockervolumes.txt;

mkdir -p "/backup/volume-copy"
for i in `cat dockervolumes.txt`; do
  rsync -avrz $voldir$i /backup/volume-copy
done

/usr/sbin/chroot /rootfs docker ps -a | grep data | gawk '{print $NF}' > containers.txt;

for i in `cat containers.txt`; do
  /usr/sbin/chroot /rootfs docker inspect $i | grep $voldir | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }' | sed 's/,//g' > volume-copy/$i-volpath.txt;
done

# add a timestamp file that show when last backup was done, can be used by check_mk/nagios
date +%s > /backup/lastrun-dockervolbck
echo ""
echo "Written lastrun timestamp in file: <backupdir>/lastrun-dockervolbck"

echo ""
echo "*************************************************************************"
echo `date` " - Backup done"
echo ""
