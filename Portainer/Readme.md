# Portainer (Docker)

Portainer est publié via Traefik sur `http://portainer.localhost`.

## Démarrage

Depuis la racine du repo :

```bash
make up-portainer
```

## Réseau

- connecté au réseau externe partagé `SHARED_NETWORK`
- non exposé directement par port host

## Persistance

Les données restent dans le volume Docker `portainer_data`.

## Notes

- Le socket Docker est monté pour permettre à Portainer de gérer les conteneurs locaux.
- L'image utilisée est pilotée par `PORTAINER_IMAGE` dans `.env`.
