# Home Streaming Set Up

Blue Sky is a personal initiative to evaluate the technical viability and complexity of removing relliance on the public cloud and live service/subscription model digital life.

This is intended only as an excercise in Docker, Docker Compose and automation via Ansible and Terraform. I do not endorse or recommend using such a set up. Please, follow all local laws and regulation regarding copyright, cryptography and digital rights management.

## Used Apps

* [Nordlynx](https://github.com/bubuntux/nordlynx)
* [Bazarr](https://www.bazarr.media/)
* [Sonarr](https://sonarr.tv/)
* [Radarr](https://radarr.video/)
* [Jackett](https://github.com/Jackett/Jackett)
* [qBittorrent](https://www.qbittorrent.org/)
* [Heimdall](https://heimdall.site/)
* [Jellyfin](https://jellyfin.org/)

## Recommended clients

* [Jellyfin](https://jellyfin.org/)
* [KODI](https://kodi.tv/) with [Jellyfin Plugin](https://github.com/jellyfin/jellyfin-kodi)
* [OSMC on Rpi](https://osmc.tv/) with [Jellyfin Plugin](https://github.com/jellyfin/jellyfin-kodi)

## Repository Structure

`download_manager` contains a collection of applications to detect new releases and automatically add them to a dowload client. This uses a nordlynx vpn tunnel for indexers, download client and release managers.

`landing_page` is a plain deployment on Heimdall to provide a simple navigation to access each individual service.

`media_server` deploys a Jellyfin instance that can be accessed by various clients.

Use `make` to control the system. See `make help` for details.

e.g.:

```
make start
make stop
```

> Note: `make clean` will remove persistent configuration. Use with care!

## Manual Configuration Steps

Application configurations are stored next to each `docker-compose.yml`. In addition, media and torrent directories are assumed to exist under `/data` on the host. If you want to use different directories, you will need to adapt the relevant `docker-compose.yml` file.

Required Directories:

* `/data/media`
* `/data/torrent`

### VPN Configuration

Manual creation of Nordlynx Private Key is required. This value must be added to `download_manager/docker-compose.yml` and requires a `restart` or `start`.

e.g.:

```
services:
## Network Gateway
  vpnbridge:
    ...
    environment:
      PRIVATE_KEY: "!THIS NEEDS TO BE CONFIGURED!"
```

### Application Configuration

#### Jackett

* Indexers

Information from this configuration will be required for Sonarr and Radarr

#### Radarr and Sonarr

* Indexers
* Download Clients

#### Bazarr

* Providers
* Languages
* Sonarr
* Radarr

#### qBittorrent

* Black Hole directory (auto-add)
* Torrent Management directories (complete,incomplete,etc)

#### Jellyfin

* Libraries
* Hardware acceleration

If you are using an Intel CPU on the host, you may expose some capabilities to accelerate video transcoding. You can do so by uncommenting the relevant lines in `media_server/docker-compose.yml`

#### Heimdall

* Apps with specific URLs for each service

## LICENSE

![CC BY-NC-SA 4.0](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png "CC BY-NC-SA 4.0")

This work is licensed under Creative Commons [Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0)
