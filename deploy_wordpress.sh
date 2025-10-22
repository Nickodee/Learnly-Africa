#!/bin/bash

# Exit on any error
set -e

echo "=== Starting Docker service ==="
sudo systemctl start docker

echo "=== Creating Docker network for WordPress and MySQL ==="
sudo docker network create wordpress-network || true

echo "=== Pulling Docker images for MySQL and WordPress ==="
sudo docker pull mysql:5.7
sudo docker pull wordpress:latest

echo "=== Running MySQL container ==="
sudo docker run -d \
  --name wordpressdb \
  --network wordpress-network \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=wppassword \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  mysql:5.7

echo "=== Running WordPress container ==="
sudo docker run -d \
  --name wordpress \
  --network wordpress-network \
  -e WORDPRESS_DB_HOST=wordpressdb:3306 \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppassword \
  -e WORDPRESS_DB_NAME=wordpress \
  -p 80:80 \
  wordpress:latest

echo "=== Checking running containers ==="
sudo docker ps

# Automatically get your EC2 public IP
EC2_IP=$(curl -s http://checkip.amazonaws.com)

echo "=================================================="
echo "🎉 WordPress is now running!"
echo "Access it in your browser at: http://$EC2_IP"
echo "=================================================="
