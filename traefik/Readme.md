# Traefik (Docker)

Traefik est le reverse proxy central du repo. Il expose les services en `*.localhost`.

## Démarrage

Depuis la racine du repo :

```bash
make up-traefik
```

## Dashboard

- URL: `http://traefik.localhost`
- Protégé par basic auth via `TRAEFIK_DASHBOARD_USERS` dans `.env`

## Configuration

- provider Docker activé
- `exposedByDefault=false`
- seul Traefik ouvre un port host (`80:80`)
