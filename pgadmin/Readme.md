# pgAdmin (Docker)

Ce dossier contient la configuration Docker Compose pour déployer rapidement pgAdmin, l'interface web d'administration PostgreSQL.

## Lancement rapide

Dans ce dossier, exécutez :

```bash
docker-compose up -d
```

Accédez ensuite à [http://localhost:5050](http://localhost:5050) dans votre navigateur.

## Identifiants par défaut

- **Email** : `admin@admin.com`
- **Mot de passe** : `admin`

Vous pouvez modifier ces valeurs dans le fichier `docker-compose.yml` (variables d'environnement `PGADMIN_DEFAULT_EMAIL` et `PGADMIN_DEFAULT_PASSWORD`).

## Persistance des données

Les données de pgAdmin sont stockées dans un volume Docker nommé `pgadmin_data` pour garantir la persistance entre les redémarrages.

## Réseau

Un réseau Docker dédié `pgadmin-net` est créé pour faciliter la connexion à d'autres conteneurs (ex : PostgreSQL).

## Arrêt et suppression

Pour arrêter pgAdmin :

```bash
docker-compose down
```
