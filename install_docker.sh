#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo dnf update -y

# Install Docker
echo "Installing Docker..."
sudo dnf install -y docker

# Enable and start Docker service
echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Verify Docker is running
sudo systemctl status docker --no-pager

echo "Docker installation completed successfully!"
