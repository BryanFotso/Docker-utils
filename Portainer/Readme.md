# Portainer Docker Compose Setup

This project provides a simple Docker Compose configuration to run Portainer, a web-based Docker management interface.

## Features
- **Portainer Community Edition**: Manage your Docker environment via a user-friendly web UI.
- **Persistent Data**: Portainer data is stored in a Docker volume (`portainer_data`).
- **Automatic Restart**: The container restarts automatically unless stopped manually.

## Usage

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Quick Start
1. Clone this repository or copy the `docker-compose.yml` file to your project directory.
2. In your terminal, navigate to the directory containing `docker-compose.yml`.
3. Start Portainer:
   ```bash
   docker compose up -d
   ```
4. Open your browser and go to [http://localhost:9000](http://localhost:9000) to access the Portainer web UI.
5. On first launch, set up your admin user and connect Portainer to your local Docker environment.

### Stopping Portainer
To stop and remove the container:
```bash
docker compose down
```

## Data Persistence
All Portainer data is stored in the Docker volume `portainer_data`. This ensures your settings and information are retained between restarts.

## Customization
- To change the Portainer version, edit the `image:` line in `docker-compose.yml` (e.g., use `portainer/portainer-ce:lts` for the LTS version).
- To use different ports, modify the `ports:` section.

## Security Note
By default, Portainer is exposed on port 9000 without HTTPS. For production use, consider enabling SSL and securing access.

## References
- [Portainer Documentation](https://docs.portainer.io/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
