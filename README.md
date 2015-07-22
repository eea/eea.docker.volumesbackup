# Ready to run Docker image to backup data containers/volumes

Docker image that allows you to backup volumes inside data containers to a
specific path on host.

This image is generic, thus you can obviously re-use it within your
non-related EEA projects.


## Supported tags and respective Dockerfile links

  - `:latest` (default)


## Base docker image

 - [hub.docker.com](https://registry.hub.docker.com/u/eeacms/volumesbackup)


## Source code

  - [github.com](http://github.com/eea/eea.docker.volumesbackup)


## Installation

1. Install [Docker](https://www.docker.com/).


## Usage

Note that `/var/local/dockerbck` is the path on host where you want this to
backup your docker data containers. Please modify it according with your needs.

### Single run

    $ docker run --rm \
      --volume=/:/rootfs:ro \
      --volume=/var/lib/docker/:/var/lib/docker:ro \
      --volume=/var/local/dockerbck:/backup:rw \
      eeacms/volumesbackup

### Run daily at 3:30 AM

    $ docker run --rm \
      --volume=/:/rootfs:ro \
      --volume=/var/lib/docker/:/var/lib/docker:ro \
      --volume=/var/local/dockerbck:/backup:rw \
      -e "SCHEDULE=30 3 * * *" \ 
      eeacms/volumesbackup

This will create a folder at `/var/local/dockerbck/volume-copy` if it does not
exist and will store the volumes content in there.

## Troubleshooting

If you are running this as a service make sure you also sync host time with
docker container time, otherwise the cron will run at 3:30 AM UTC time. 
See bellow how to fix this:

    $ docker run --rm \
     --volume=/etc/localtime:/etc/localtime:ro
     ...
    eeacms/volumesbackup


## Copyright and license

The Initial Owner of the Original Code is European Environment Agency (EEA).
All Rights Reserved.

The Original Code is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later
version.


## Funding

[European Environment Agency (EU)](http://eea.europa.eu)
