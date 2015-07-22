#!/bin/bash

if [[ ! -d "/backup/volume-copy" ]]; then
    mkdir -p "/backup/volume-copy"
fi

chmod 777 /backup/volume-copy;
dockerver=$(chroot /rootfs docker -v | gawk '{print $3}' | sed 's/,//g')

if [[ $dockerver == 1.5* ]] || [[ $dockerver == 1.6* ]]; then
  voldir="/var/lib/docker/vfs/dir/"
else
  voldir="/var/lib/docker/volumes/"
fi

cd /backup;
ls $voldir > dockervolumes.txt;

for i in `cat dockervolumes.txt`; do
  rsync -avrz /$i /backup
done

chroot /rootfs docker ps -a | grep data | gawk '{print $NF}' > containers.txt;

for i in `cat containers.txt`; do
  chroot docker inspect $i | grep $voldir | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }' | sed 's/,//g' > volume-copy/$i-volpath.txt;
done
