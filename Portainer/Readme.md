# Portainer

Configuration Docker Compose pour lancer Portainer Community Edition en local.

## Préparation

Le réseau partagé doit exister :

```bash
docker network create docker-utils
```

## Usage

```bash
docker compose up -d
```

Accès : http://localhost:9000

## Configuration

- Image : `portainer/portainer-ce:lts`
- Port local : `PORTAINER_PORT`, défaut `9000`
- Adresse d'écoute : `PORTAINER_BIND_ADDRESS`, défaut `127.0.0.1`
- Réseau partagé : `DOCKER_UTILS_NETWORK`, défaut `docker-utils`
- Volume persistant : `portainer_data`

## Arrêt

```bash
docker compose down
```
