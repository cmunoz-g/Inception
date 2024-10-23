# install docker & docker compose
sudo apt-get update
sudo apt-get install docker.io
sudo apt-get install docker-compose

# to check if it was installed correctly:
docker --version
docker compose --version

# configuration of each container
## nginx w/ TSLv1.2 or TSLv1.3 (HTTP web server)
### build docker
docker build -t nginx . (in the nginx directory)
docker run -it nginx (-it opens the container terminal)

# useful commands
systemctl status docker (check if docker is running)
systemctl start docker (start docker)

docker images (check the docker images)
docker rmi [image_id] || docker rmi [repository]:[tag] (deletes a docker image)

docker ps -a (know the containers currently launched)
docker rm [container_id] (stops a container)

# useful info
The CMD instruction in a Dockerfile defines the default command that will be executed
when the container starts.
daemon off tells NGINX to run in the foreground, which keeps the process alive in the terminal