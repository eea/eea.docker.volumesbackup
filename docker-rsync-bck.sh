#!/bin/bash
docker run --rm \
    --volume=/:/rootfs:ro \
    --volume=/var/lib/docker/:/var/lib/docker:ro \
    --volume=/var/local/dockerbck:/backup:rw \
    eeacms/volumesbackup
