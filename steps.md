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
docker rmi $(docker images -q) (deletes all images)

docker ps -a (know the containers currently launched)
docker stop [container_id] (stops a container)
docker stop $(docker ps -q) (stops all containers)
docker rm [container_id] (removes a container)
docker rm $(docker ps -aq) (removes all containers)

# useful info
The CMD instruction in a Dockerfile defines the default command that will be executed
when the container starts.
"daemon off" tells NGINX to run in the foreground, which keeps the process alive in the terminal
"req" creates and processes certificate requests in PKCS#10 format, -x509 is the type of certificate,
-nodes leaves the private key without a password

# config https login
cd /etc
vim hosts
add a line that redirects 127.0.0.1 to my login url
set it in nginx conf