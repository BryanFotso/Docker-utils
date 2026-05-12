# n8n

Ce dossier lance n8n en local avec Docker Compose.

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

Accès : http://localhost:5678

Le service `n8n-init-db` crée automatiquement le schéma PostgreSQL avant le démarrage de n8n.

## Configuration

- Image : `n8nio/n8n:latest`
- Port local : `N8N_HOST_PORT`, défaut `5678`
- Adresse d'écoute locale : `N8N_BIND_ADDRESS`, défaut `127.0.0.1`
- URL utilisée pour les webhooks : `WEBHOOK_URL`, défaut `http://localhost:5678/`
- Fuseau horaire : `GENERIC_TIMEZONE`, défaut `Europe/Paris`
- Réseau partagé : `DOCKER_UTILS_NETWORK`, défaut `docker-utils`
- Volume persistant : `n8n_data`
- Dossier local partagé : `./local-files`, visible dans n8n sous `/files`

## Communication avec les autres outils

n8n rejoint le réseau `docker-utils`. Il peut donc joindre les autres services par leur nom Docker.

n8n est configuré pour utiliser la base PostgreSQL commune du dépôt, mais dans son propre schéma :

```text
host: postgres
port: 5432
database: mydb
schema: n8n
```

## Base de données PostgreSQL

Cette stack utilise PostgreSQL avec :

- `DB_TYPE=postgresdb`
- `DB_POSTGRESDB_DATABASE=mydb`
- `DB_POSTGRESDB_SCHEMA=n8n`

Le schéma `n8n` permet d'isoler les tables n8n dans la base commune, sans affecter les autres outils.

Au lancement, le service `n8n-init-db` attend PostgreSQL puis exécute `CREATE SCHEMA IF NOT EXISTS n8n`. Cette opération est idempotente : elle ne supprime rien et n'affecte pas les autres schémas.

PostgreSQL doit déjà être démarré :

```bash
cd ../postgresql
docker compose up -d
```

Les paramètres sont configurables avec `DB_POSTGRESDB_HOST`, `DB_POSTGRESDB_PORT`, `DB_POSTGRESDB_DATABASE`, `DB_POSTGRESDB_USER`, `DB_POSTGRESDB_PASSWORD` et `DB_POSTGRESDB_SCHEMA`.

Le volume `n8n_data` reste utile : n8n y stocke notamment ses fichiers de configuration locaux et sa clé de chiffrement.

## Arrêt

```bash
docker compose down
```
