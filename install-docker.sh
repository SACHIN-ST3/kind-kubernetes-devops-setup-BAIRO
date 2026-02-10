#!/bin/bash
set -e

echo "🔹 Installing Docker..."

sudo apt update
sudo apt install docker.io -y

sudo systemctl start docker
sudo systemctl enable docker

echo "🔹 Adding user to docker group..."
sudo usermod -aG docker $USER

echo "✅ Docker installed successfully!"
docker --version

echo "⚠️ Logout & login again to apply docker group changes"

