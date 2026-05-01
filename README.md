[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)
[![Build and Test](https://github.com/librasteve/cragcli-info/actions/workflows/ci.yml/badge.svg)](https://github.com/librasteve/cragcli-info/actions/workflows/ci.yml)

# Cragcli

Code for the cragcli.info website.

Please visit https://github.com/librasteve/raku-App-Crag (the repo) or https://cragcli.info (the website) for more info...

## Local Installation

### Install Cro & Air, Cro
- `zef install --/test cro Air`

If this is your first Raku installation, you may need some native libraries for dependencies (e.g. for UUID, SSL), please check the module specific documentation for help.

Red is not currently used by this website.

You will also need a SASS compiler such as Dart.

### Git clone this repo
- `git clone https://github.com/librasteve/cragcli-info.git`
- `cd Cragcli`

### Run and view it
- `raku -I. air-serve.raku :scss :watch`
- Open a browser and go to `http://localhost:3000`

---

## Server Installation

Setup your server with a basic Raku install - for example Ubuntu LTS 24.04 with templates/setup.pl (which assumes user
`ubuntu`).

A Dart compiler is not needed for the server, provided you have it on your development box.

Make a directory structure like this:

```
my_webapp/
├── Caddyfile
├── docker-compose.yml
└── update-sites.sh
```

Populate the files from the examples given in templates/ (single-site or multi-site).

Point your domain name(s) to this IP address (ie. match the Caddyfile).

### Manual Restart

Then go:

```
[sudo docker compose down]
[sudo docker compose pull]
sudo docker compose up -d
```

### Auto Restart

To have the server poll quay.io for a new image every 15mins (the image is made by GitHub action on commit to main), then adjust the update-sites.sh and go:

```
crontab -e (as root)
*/14 * * * * echo "$(date '+\%Y-\%m-\%d \%H:\%M:\%S')" >> /var/log/update-sites.log 2>&1
*/15 * * * * /home/ubuntu/update-sites.sh >> /var/log/update-sites.log 2>&1
```

---

# COPYRIGHT AND LICENSE

Copyright(c) 2026 Stephen Roe

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
