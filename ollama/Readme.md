# Ollama + Open WebUI

Ce dossier lance Ollama et Open WebUI en local avec Docker Compose.

## Préparation

Le réseau partagé doit exister :

```bash
docker network create docker-utils
```

Copiez l'exemple de configuration si vous voulez personnaliser les valeurs :

```bash
cp .env.example .env
```

## Lancement rapide

Dans ce dossier, exécutez :

```bash
docker compose up -d
```

Accès :

- Open WebUI : http://localhost:3000
- API Ollama : http://localhost:11434

Au premier accès à Open WebUI, créez le compte administrateur.

## Configuration

### Ollama

- Image : `ollama/ollama:latest`
- Port local : `OLLAMA_PORT`, défaut `11434`
- Adresse d'écoute locale : `OLLAMA_BIND_ADDRESS`, défaut `127.0.0.1`
- Conservation des modèles en mémoire : `OLLAMA_KEEP_ALIVE`, défaut `5m`
- Réseau partagé : `DOCKER_UTILS_NETWORK`, défaut `docker-utils`
- Volume persistant : `ollama_data`

### Open WebUI

- Image : `ghcr.io/open-webui/open-webui:main`
- Port local : `OPEN_WEBUI_PORT`, défaut `3000`
- Adresse d'écoute locale : `OPEN_WEBUI_BIND_ADDRESS`, défaut `127.0.0.1`
- URL Ollama interne : `OPEN_WEBUI_OLLAMA_BASE_URL`, défaut `http://ollama:11434`
- Authentification : `OPEN_WEBUI_AUTH`, défaut `true`
- Volume persistant : `open_webui_data`

## Télécharger un modèle

Exemple avec Llama 3.1 :

```bash
docker compose exec ollama ollama pull llama3.1
```

Lancer une invite interactive :

```bash
docker compose exec ollama ollama run llama3.1
```

Lister les modèles installés :

```bash
docker compose exec ollama ollama list
```

## Communication avec les autres outils

Ollama rejoint le réseau `docker-utils`. Les autres conteneurs du réseau peuvent l'appeler avec :

```text
host: ollama
port: 11434
base url: http://ollama:11434
```

Exemple depuis n8n : utilisez `http://ollama:11434` comme URL de base Ollama.

Open WebUI utilise aussi cette URL interne :

```text
OLLAMA_BASE_URL=http://ollama:11434
```

## GPU NVIDIA

La configuration par défaut fonctionne en CPU.

Pour utiliser un GPU NVIDIA, installez le NVIDIA Container Toolkit sur l'hôte puis ajoutez cette section au service `ollama` :

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities:
            - gpu
```

Selon votre version de Docker Compose, vous pouvez aussi utiliser :

```yaml
gpus: all
```

## Arrêt

```bash
docker compose down
```
