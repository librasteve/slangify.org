## Purpose

Define the CI/CD pipeline, Docker image build, and server deployment for slangify.org.

## Requirements

### Requirement: Docker image build

The site SHALL be packaged as a Docker image based on `docker.io/rakudo-star:latest`. The build SHALL:
1. Install system dependencies: `uuid-dev libpq-dev libssl-dev unzip build-essential`
2. Copy `META6.json` and run `zef install --/test --deps-only` to install Raku dependencies
3. Copy the full application source
4. Validate syntax with `raku -c -Ilib air-start.raku`
5. Set `CRO_WEBSITE_HOST=0.0.0.0` and `CRO_WEBSITE_PORT=3000`
6. Start with `CMD ["raku", "-Ilib", "air-start.raku"]`

The build SHALL accept a `quay_expiration` build arg (default `never`) applied as a `quay.expires-after` label.

#### Scenario: Image builds and starts

- **WHEN** the Docker image is built and run
- **THEN** the Cro HTTP server starts on port 3000
- **AND** the site is accessible at `http://localhost:3000`

### Requirement: CI/CD pipeline

On every push to `main`, GitHub Actions SHALL invoke `scripts/cibuild.sh container` to build and push the image to `quay.io/librasteve/slangify-org`. The workflow requires `QUAY_USERNAME` and `QUAY_PASSWORD` secrets.

Both a versioned tag and `:latest` SHALL be pushed.

#### Scenario: Push to main triggers image publish

- **WHEN** a commit is pushed to the `main` branch
- **THEN** GitHub Actions builds the Docker image
- **AND** pushes it to `quay.io/librasteve/slangify-org:latest`

### Requirement: Multi-site server deployment

The site SHALL be deployed as the `slangify-org` service in the multi-site `docker-compose.yml` (in `templates/multi-site/`). It SHALL:
- Use image `quay.io/librasteve/slangify-org:latest`
- Expose internal port 3000 (no host port binding)
- Be on the `webnet` network
- Have `restart: unless-stopped`

Caddy SHALL reverse-proxy `slangify.org { reverse_proxy slangify-org:3000 }` with automatic TLS.

#### Scenario: Site is reachable via domain

- **WHEN** the multi-site docker-compose stack is running
- **THEN** `https://slangify.org` is served by the `slangify-org` container via Caddy
- **AND** TLS is handled automatically by Caddy ACME

### Requirement: Auto-update from registry

The server SHALL poll `quay.io` for a new image every 15 minutes via `update-sites.sh` run from cron. When a new image is detected, the compose stack SHALL pull and restart.

#### Scenario: New image is deployed automatically

- **WHEN** a new image is pushed to `quay.io/librasteve/slangify-org:latest`
- **THEN** within 15 minutes the server pulls the new image and restarts the container
