# PostgreSQL (Docker Compose)

Stack PostgreSQL connectée au réseau externe partagé `SHARED_NETWORK`.

## Démarrage

Depuis la racine du repo :

```bash
make up-postgresql
```

## Exposition réseau

- Par défaut, PostgreSQL est accessible uniquement depuis le réseau Docker partagé (host interne: `postgres`, port `5432`).
- Aucun port n'est exposé sur l'hôte local.

### Mode debug (optionnel)

Pour exposer temporairement PostgreSQL sur l'hôte :

```bash
make up-postgresql-debug
```

Puis connexion locale sur `localhost:${POSTGRES_DEBUG_PORT}`.

## Variables `.env`

- `POSTGRES_IMAGE`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB`
- `POSTGRES_DEBUG_PORT`

## Persistance

Les données restent dans le volume Docker `pgdata`.
