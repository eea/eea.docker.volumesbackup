# eea.docker.volumesbackup

This repo containes script to backup and restore docker containers volumes via rsync.

The volumes are stored in a specific folder on the docker host, where other external backup software will backup at regular basis.

### How to use it

Just run the shell script on the host where you have your docker containers running.
```
   $ git clone https://github.com/eea/eea.docker.volumesbackup.git dockerbck
   $ cd dockerbck
   $ chmod a+x docker-rsync-bck.sh
   $ ./docker-rsync-bck.sh
```
The script will create a subfolder ```volume-copy`` if does not exist and store the volumes content in there.

### TODO
- To be dockerised. So that we can run it like:
```
docker run --rm \
       -v /path/to/dockerbackup:/var/local/dockerbck/volume-copy:rw \
       -v /var/lib/docker/:/var/lib/docker:ro \
       eeacms/volumesbackup
```

- Make it compatible with Docker 1.7, since the location of volumes has changed. Docker 1.7 doesn't store anymore volumes to /var/lib/docker/vfs. It stores them to /var/lib/docker/volumes/<container_id>/_data
