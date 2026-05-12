# pgAdmin (Docker)

Ce dossier contient la configuration Docker Compose pour déployer rapidement pgAdmin, l'interface web d'administration PostgreSQL.

## Préparation

Le réseau partagé doit exister :

```bash
docker network create docker-utils
```

## Lancement rapide

Dans ce dossier, exécutez :

```bash
docker compose up -d
```

Accédez ensuite à [http://localhost:5050](http://localhost:5050) dans votre navigateur.

## Identifiants par défaut

- **Email** : `admin@admin.local`
- **Mot de passe** : `change-me`

Vous pouvez modifier ces valeurs avec les variables `PGADMIN_DEFAULT_EMAIL` et `PGADMIN_DEFAULT_PASSWORD`.

## Persistance des données

Les données de pgAdmin sont stockées dans un volume Docker nommé `pgadmin_data` pour garantir la persistance entre les redémarrages.

## Réseau

pgAdmin rejoint le réseau partagé `docker-utils`. Pour enregistrer le PostgreSQL de ce dépôt dans pgAdmin :

```
host: postgres
port: 5432
database: mydb
```

## Arrêt et suppression

Pour arrêter pgAdmin :

```bash
docker compose down
```
