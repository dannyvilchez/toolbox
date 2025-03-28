# DOCKER CHEATSHEET 

## SECTION 1: DOCKER CLI COMMANDS

```bash
# List all running containers
docker ps

# List all containers (including stopped)
docker ps -a

# List all images on the system
docker images

# Pull an image from Docker Hub
docker pull image_name

# Build an image from a Dockerfile
docker build -t image_name .

# Run a container from an image
docker run image_name

# Run a container interactively with terminal
docker run -it image_name /bin/bash

# Run a container in the background (detached mode)
docker run -d image_name

# Run a container and map ports
docker run -p host_port:container_port image_name

# Assign a name to a container
docker run --name container_name image_name

# Start a stopped container
docker start container_name

# Stop a running container
docker stop container_name

# Remove a container
docker rm container_name

# Remove an image
docker rmi image_name

# View logs from a container
docker logs container_name

# Execute a command in a running container
docker exec -it container_name bash

# Copy files from container to host
docker cp container_name:/path/in/container /path/on/host

# Prune everything (remove stopped containers, unused networks, images, etc.)
docker system prune

```
## SECTION 2: DOCKER COMPOSE COMMANDS
*These are run in the directory with your docker-compose.yml*

```bash
# Start services in background
docker-compose up -d

# Start services with log output
docker-compose up

# Stop services
docker-compose down

# Build or rebuild services
docker-compose build

# Rebuild and start containers
docker-compose up --build

# List running services
docker-compose ps

# View logs from services
docker-compose logs

# Execute a command in a running service container
docker-compose exec service_name bash

# Restart services
docker-compose restart

# Remove stopped containers and volumes
docker-compose down -v

```
