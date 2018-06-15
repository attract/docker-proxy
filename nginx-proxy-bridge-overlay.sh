#DOCKER SETTINGS
# export DOCKER_HOST=127.0.0.1:2377
export NET="docker-proxy-overlay"
export PROJECT_IMAGE="jwilder/nginx-proxy"
export PROJECT_NAME="docker-proxy"
 
#check  if  overlay  network  exist  to  connect  proxy  to  it 
if ! docker  network  ls | grep $NET > /dev/null 
  then
    docker  network create \
        --attachable \
        -d overlay \
        $NET   
fi
 
#remove  container  if exist
if [ `docker ps -a | grep "$PROJECT_NAME" | wc -l` -gt 0 ]; then 
	docker stop $PROJECT_NAME; 
    docker rm  -f $PROJECT_NAME; 
fi
 
docker run -d \
           --network $NET \
           -p 80:80 \
	   -p 5000:5000 \
           --restart=always \
           -v ~/docker-proxy/nginx.conf:/etc/nginx/nginx.conf \
           -v /var/run/docker.sock:/tmp/docker.sock:ro \
           --name $PROJECT_NAME \
           $PROJECT_IMAGE

docker network connect bridge docker-proxy
