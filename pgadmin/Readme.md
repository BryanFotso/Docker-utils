# pgAdmin (Docker)

pgAdmin est exposé via Traefik sur `http://pgadmin.localhost`.

## Démarrage

Depuis la racine du repo :

```bash
make up-pgadmin
```

## Identifiants

Les credentials sont lus depuis `.env` :

- `PGADMIN_DEFAULT_EMAIL`
- `PGADMIN_DEFAULT_PASSWORD`

## Réseau

- connecté au réseau externe partagé `SHARED_NETWORK`
- accès à PostgreSQL via host `postgres` et port `5432`

## Persistance

Les données sont stockées dans le volume Docker `pgadmin_data`.
