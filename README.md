# Docker Subsonic with Docker-compose
* Fork from: marcopaganini/alpine-subsonic
* 2022-11 : functionnal with docker-compose

# alpine-subsonic
This repository contains configuration to build a
[Subsonic](http://subsonic.org) media streamer [Docker](http://docker.io)
container. This work was derived from [Michael Scherig](https://github.com/mschuerig)'s [Subsonic Docker Image](https://github.com/mschuerig/subsonic-docker-image) repo, but uses Alpine Linux as the base container for a smaller footprint (about 250M vs 512M for the Debian based version).


## Notes
* Subsonic 6.1.6 (http://www.subsonic.org)
* Alpine Linux
* Runs as user subsonic (UID 10000)
* Use with docker-compose
* Can use local directory for Music & DB

## Installing
* Clone repository
* Edit docker-compose.env file
* Launch build.sh script :

```shell
$ ./build.sh
```

## Building your own image & launch it
It is also possible to build your own image:
```shell
  $ git clone http://github.com/marcopaganini/alpine-subsonic.git
  $ cd alpine-subsonic
  $ ./build.sh
```

## Prerequistes
* Create user subsonic on your host computer, uid 10000 (or update the env file)

* For the example below, we assume your media is under `SUBSONIC_HOST_MUSIC_DIR` and
  can be read by uid 10000 on the host computer. (either chmod your entire
  media library o+rX or set it to the correct uid/gid). Feel free to change the
  media directory to match your reality.

* We'll save state under `SUBSONIC_HOST_HOME` on the *host* computer. This makes it easier
  to update the containers and backup state information (DB).

Point your browser to http://your_host:4040 and proceed with the web-based Subsonic
setup. See Subsonic's home page at http://subsonic.org for documentation.

You can use Reverse Proxy with proxy_pass to ad your SSL certificate.

## Acknowledgements

Again, my thanks to [Michael Schuerig](https://github.com/mschuerig) for the idea and
his configuration and for `marcopaganini` for his repository.

## Feedback

If you find bugs, open a bug in Github or send a Change request with a fix. Feedback
is always appreciated.
