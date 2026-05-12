## PostgreSQL avec Docker Compose

Ce dossier lance une instance PostgreSQL locale via Docker Compose.

### Préparation

Le réseau partagé doit exister :

```bash
docker network create docker-utils
```

### Lancement rapide

Dans ce dossier, exécutez :

```bash
docker compose up -d
```

La base de données est exposée localement sur `127.0.0.1:5433` par défaut.

### Paramètres par défaut

- **Utilisateur** : `user`
- **Mot de passe** : `change-me`
- **Base de données** : `mydb`

Vous pouvez modifier ces valeurs avec les variables `POSTGRES_USER`, `POSTGRES_PASSWORD` et `POSTGRES_DB`.

### Persistance des données

Les données sont stockées dans un volume Docker nommé `pgdata` pour garantir la persistance même après l'arrêt du conteneur.

### Schémas par outil

Cette base peut servir à plusieurs outils. Chaque outil doit utiliser son propre schéma pour éviter les collisions.

La création des schémas reste dans la stack de chaque outil. Par exemple, la stack n8n crée automatiquement son schéma `n8n` avant de démarrer.

Convention recommandée :

- base commune : `mydb`
- un schéma par outil : `n8n`, `grafana`, `keycloak`, etc.
- un nom de schéma simple : minuscules, chiffres et underscores uniquement
- pas de tables d'outil dans le schéma `public`

Depuis un conteneur du réseau `docker-utils`, les paramètres PostgreSQL communs sont :

```text
host: postgres
port: 5432
database: mydb
user: user
password: change-me
```

Pour créer manuellement un schéma sans toucher aux autres :

```bash
docker compose exec postgres psql -U user -d mydb -c 'CREATE SCHEMA IF NOT EXISTS mon_outil;'
```

Pour un nouvel outil, préférez créer le schéma depuis la stack de l'outil avec un service d'init idempotent :

```yaml
services:
  mon-outil-init-db:
    image: postgres:16-alpine
    restart: "no"
    environment:
      PGPASSWORD: ${DB_POSTGRESDB_PASSWORD:-change-me}
    command:
      - sh
      - -c
      - |
        until pg_isready -h "${DB_POSTGRESDB_HOST:-postgres}" -p "${DB_POSTGRESDB_PORT:-5432}" -U "${DB_POSTGRESDB_USER:-user}" -d "${DB_POSTGRESDB_DATABASE:-mydb}"; do
          sleep 2
        done
        psql -v ON_ERROR_STOP=1 \
          -h "${DB_POSTGRESDB_HOST:-postgres}" \
          -p "${DB_POSTGRESDB_PORT:-5432}" \
          -U "${DB_POSTGRESDB_USER:-user}" \
          -d "${DB_POSTGRESDB_DATABASE:-mydb}" \
          -c 'CREATE SCHEMA IF NOT EXISTS "mon_outil";' \
          -c 'GRANT USAGE, CREATE ON SCHEMA "mon_outil" TO "${DB_POSTGRESDB_USER:-user}";'
    networks:
      - tools

  mon-outil:
    image: image/open-source:tag
    depends_on:
      mon-outil-init-db:
        condition: service_completed_successfully
    environment:
      DB_TYPE: postgresdb
      DB_POSTGRESDB_HOST: ${DB_POSTGRESDB_HOST:-postgres}
      DB_POSTGRESDB_PORT: ${DB_POSTGRESDB_PORT:-5432}
      DB_POSTGRESDB_DATABASE: ${DB_POSTGRESDB_DATABASE:-mydb}
      DB_POSTGRESDB_USER: ${DB_POSTGRESDB_USER:-user}
      DB_POSTGRESDB_PASSWORD: ${DB_POSTGRESDB_PASSWORD:-change-me}
      DB_POSTGRESDB_SCHEMA: ${DB_POSTGRESDB_SCHEMA:-mon_outil}
    networks:
      - tools
```

Adaptez les noms des variables si l'outil n'utilise pas les mêmes noms que n8n. Le principe reste le même : l'outil pointe vers la base `mydb` et son propre schéma.

### Connexion

Depuis la machine hôte :

```
host: localhost
port: 5433
user: user
password: change-me
database: mydb
```

Depuis un autre conteneur du réseau `docker-utils` :

```
host: postgres
port: 5432
```

### Arrêt et suppression

Pour arrêter :

```bash
docker compose down
```

Pour supprimer les données (attention, action destructive) :

```bash
docker compose down -v
```
