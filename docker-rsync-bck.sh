#!/bin/bash

if [[ ! -d "/var/local/dockerbck/volume-copy" ]]; then
    mkdir -p "/var/local/dockerbck/volume-copy"
fi

chmod 777 /var/local/dockerbck/volume-copy;
cd /var/local/dockerbck;
ls /var/lib/docker/vfs/dir/ > dockervolumes.txt;
for i in `cat dockervolumes.txt`; do
docker run --rm -ti -v /var/lib/docker/vfs/dir/$i:/$i  -v $(pwd)/volume-copy:/backup rsync/centos rsync -avrz /$i /backup
done;
docker ps -a | grep data | gawk '{print $NF}' > containers.txt;
for i in `cat containers.txt`; do
docker inspect $i | grep "vfs/dir" | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }' | sed 's/,//g' > volume-copy/$i-volpath.txt;
done;
