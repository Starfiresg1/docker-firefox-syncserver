<p align="center"><a href="https://github.com/crazy-max/docker-firefox-syncserver" target="_blank"><img height="128"src="https://raw.githubusercontent.com/crazy-max/docker-firefox-syncserver/master/.res/docker-firefox-syncserver.jpg"></a></p>

<p align="center">
  <a href="https://hub.docker.com/r/crazymax/firefox-syncserver/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/github/v/tag/crazy-max/docker-firefox-syncserver?label=version&style=flat-square" alt="Latest Version"></a>
  <a href="https://github.com/crazy-max/docker-firefox-syncserver/actions"><img src="https://github.com/crazy-max/docker-firefox-syncserver/workflows/build/badge.svg" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/firefox-syncserver/"><img src="https://img.shields.io/docker/stars/crazymax/firefox-syncserver.svg?style=flat-square" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/firefox-syncserver/"><img src="https://img.shields.io/docker/pulls/crazymax/firefox-syncserver.svg?style=flat-square" alt="Docker Pulls"></a>
  <a href="https://www.codacy.com/app/crazy-max/docker-firefox-syncserver"><img src="https://img.shields.io/codacy/grade/d6131942609e4d0ba34953e87d26f455.svg?style=flat-square" alt="Code Quality"></a>
  <br /><a href="https://www.patreon.com/crazymax"><img src="https://img.shields.io/badge/donate-patreon-f96854.svg?logo=patreon&style=flat-square" alt="Support me on Patreon"></a>
  <a href="https://www.paypal.me/crazyws"><img src="https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square" alt="Donate Paypal"></a>
</p>

## About

🐳 [Firefox Sync Server](http://moz-services-docs.readthedocs.io/en/latest/howtos/run-sync-1.5.html) image based on Python Alpine Linux.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other 🐳 Docker images!

💡 Want to be notified of new releases? Check out 🔔 [Diun (Docker Image Update Notifier)](https://github.com/crazy-max/diun) project!

## Features

* [Traefik](https://github.com/containous/traefik-library-image) as reverse proxy and creation/renewal of Let's Encrypt certificates

## Docker

### Multi-platform image

Following platforms for this image are available:

```
$ docker run --rm mplatform/mquery crazymax/firefox-syncserver:latest
Image: crazymax/firefox-syncserver:latest
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v6
   - linux/arm/v7
   - linux/arm64
   - linux/386
   - linux/ppc64le
   - linux/s390x
```

### Environment variables

* `TZ`: The timezone assigned to the container (default `UTC`)
* `FF_SYNCSERVER_ACCESSLOG`: Display access log (default `false`)
* `FF_SYNCSERVER_LOGLEVEL`: Log level output (default `info`)
* `FF_SYNCSERVER_PUBLIC_URL`: Must be edited to point to the public URL of your server (default `http://localhost:5000`).
* `FF_SYNCSERVER_SECRET`: This is a secret key used for signing authentication tokens. It should be long and randomly-generated.
* `FF_SYNCSERVER_ALLOW_NEW_USERS`: Set this to `false` to disable new-user signups on the server. Only request by existing accounts will be honoured (default `true`).
* `FF_SYNCSERVER_FORCE_WSGI_ENVIRON`: Set this to `true` to work around a mismatch between public_url and the application URL as seen by python, which can happen in certain reverse-proxy hosting setups (default `false`).
* `FF_SYNCSERVER_SQLURI`: Defines the database in which to store all server data (default `sqlite:///data/syncserver.db`).
* `FF_SYNCSERVER_FORWARDED_ALLOW_IPS`: Set this to `*` or an IP range if you use an Nginx reverse proxy (optional). 

### Volumes

* `/data` : Contains SQLite database if `FF_SYNCSERVER_SQLURI` is untouched

> :warning: Note that the volume should be owned by uid `1000` and gid `1000`. If you don't give the volume correct permissions, the container may not start.

### Ports

* `5000` : Gunicorn port

## Use this image

### Docker Compose

Docker compose is the recommended way to run this image. You can use the following [docker compose template](examples/compose/docker-compose.yml), then run the container :

```bash
touch acme.json
chmod 600 acme.json
docker-compose up -d
docker-compose logs -f
```

### Command line

You can also use the following minimal command :

```bash
$ docker run -d -p 5000:5000 --name firefox_syncserver \
  -e TZ="Europe/Paris" \
  -e FF_SYNCSERVER_SECRET="5up3rS3kr1t" \
  -v $(pwd)/data:/data \
  crazymax/firefox-syncserver:latest
```

## Notes

### Use with MySQL database

Set `FF_SYNCSERVER_SQLURI=pymysql://user:password@mysql_server_ip/db_name`

## Update

Recreate the container whenever I push an update :

```bash
docker-compose pull
docker-compose up -d
```

## How can I help ?

All kinds of contributions are welcome :raised_hands:!<br />
The most basic way to show your support is to star :star2: the project, or to raise issues :speech_balloon:<br />
But we're not gonna lie to each other, I'd rather you buy me a beer or two :beers:!

[![Support me on Patreon](.res/patreon.png)](https://www.patreon.com/crazymax) 
[![Paypal Donate](.res/paypal.png)](https://www.paypal.me/crazyws)

## License

MIT. See `LICENSE` for more details.
