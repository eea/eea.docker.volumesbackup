# Ready to run Docker image to backup volumes

Docker image that allows you to backup volumes from your containers to a
specific path on host.

This image is generic, thus you can obviously re-use it within your
non-related EEA projects.


## Supported tags and respective Dockerfile links

  - `:latest` (default)
  - `:1.0`


## Base docker image

 - [hub.docker.com](https://registry.hub.docker.com/u/eeacms/volumesbackup)


## Source code

  - [github.com](http://github.com/eea/eea.docker.volumesbackup)


## Installation

1. Install [Docker](https://www.docker.com/).


## Usage

Note that `/var/local/dockerbck` is the path on host where you want this to
backup your docker data containers. Please modify it according with your needs.
As a best practice this should be on a different drive (external hard-disk, nfs, etc.)

This will create a folder at `/var/local/dockerbck/volume-copy` if it does not
exist and will store the volumes content in there.


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


### Run via docker-compose daily at 3:30 AM

Edit `docker-compose.yml`

    backup:
      image: eeacms/volumesbackup
      volumes:
      - /:/rootfs:ro
      - /var/lib/docker:/var/lib/docker:ro
      - /etc/localtime:/etc/localtime:ro
      - /var/local/dockerbck:/backup:rw
      environment:
      - SCHEDULE=30 3 * * *

Start

    $ docker-compose up -d
    $ docker-compose logs

Upgrade

    $ docker-compose pull

    $ docker-compose stop
    $ docker-compose rm -v
    $ docker-compose up -d


## Troubleshooting

If you are running this as a service make sure you also sync host time with
docker container time, otherwise the cron will run at 3:30 AM UTC time and not
your local time. See bellow how to fix this:

    $ docker run --rm \
     --volume=/etc/localtime:/etc/localtime:ro
     ...
    eeacms/volumesbackup


## Supported environment variables ##

* `SCHEDULE` Schedule backup at specific time with cron (e.g. `SCHEDULE=30 3 * * *`)
  Check [wikipedia](https://en.wikipedia.org/wiki/Cron#Configuration_file)
  for more details about crontab format.


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