#!/bin/bash
docker run --rm \
    --volume=/var/local/dockerbck:/backup:rw \
    --volume=/:/rootfs:ro \
    --volume=/var/lib/docker/:/var/lib/docker:ro \
    --volume=/etc/localtime:/etc/localtime:ro \
    eeacms/volumesbackup
