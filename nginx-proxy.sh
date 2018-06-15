docker stop nginx-proxy
docker rm -f nginx-proxy
docker run -d -p 80:80 -p 5000:5000 -v /var/run/docker.sock:/tmp/docker.sock:ro -v ~/docker-proxy/nginx.conf:/etc/nginx/nginx.conf --name nginx-proxy --restart=always jwilder/nginx-proxy
