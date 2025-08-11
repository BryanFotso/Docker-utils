## PostgreSQL avec Docker Compose

Ce dossier permet de lancer rapidement une instance PostgreSQL prête à l'emploi via Docker Compose.

### Lancement rapide

Dans ce dossier, exécutez :

```bash
docker-compose up -d
```

La base de données sera accessible sur le port `5432`.

### Paramètres par défaut

- **Utilisateur** : `user`
- **Mot de passe** : `K8N$0Fsa6m$9vGyd`
- **Base de données** : `mydb`

Vous pouvez modifier ces valeurs dans le fichier `docker-compose.yml`.

### Persistance des données

Les données sont stockées dans un volume Docker nommé `pgdata` pour garantir la persistance même après l'arrêt du conteneur.

### Connexion

Pour se connecter avec un client PostgreSQL :

```
host: localhost
port: 5432
user: user
password: K8N$0Fsa6m$9vGyd
database: mydb
```

### Arrêt et suppression

Pour arrêter :

```bash
docker-compose down
```

Pour supprimer les données (attention, action destructive) :

```bash
docker-compose down -v
```
