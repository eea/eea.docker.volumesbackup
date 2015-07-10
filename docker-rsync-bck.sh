##########docker volume backup final version with docker structure, also using docker version updated by Adrian
#!/bin/bash

if [[ ! -d "/var/local/dockerbck/volume-copy" ]]; then
    mkdir -p "/var/local/dockerbck/volume-copy"
fi

chmod 777 /var/local/dockerbck/volume-copy;
dockerver=$(docker -v | gawk '{print $3}' | sed 's/,//g')

if [[ $dockerver == 1.5* ]] || [[ $dockerver == 1.6* ]]; then
                voldir="/var/lib/docker/vfs/dir/"
                echo "old dir"
else
                voldir="/var/lib/docker/volumes/"
                echo "new dir"
fi

cd /var/local/dockerbck;
ls $voldir > dockervolumes.txt;

for i in `cat dockervolumes.txt`; do
        docker run --rm -ti -v $voldir$i:/$i  -v $(pwd)/volume-copy:/backup rsync/centos rsync -avrz /$i /backup
done;

docker ps -a | grep data | gawk '{print $NF}' > containers.txt;

for i in `cat containers.txt`; do
        docker inspect $i | grep $voldir | awk '/"(.*)"/ { gsub(/"/,"",$2); print $2 }' | sed 's/,//g' > volume-copy/$i-volpath.txt;
done;
