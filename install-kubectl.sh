#!/bin/bash

# Exit script immediately if any command fails
set -e

echo "🔹 Downloading latest kubectl binary..."

# Download the latest stable kubectl version
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

echo "🔹 Making kubectl executable..."

# Give execute permission
chmod +x kubectl

echo "🔹 Moving kubectl to /usr/local/bin..."

# Move kubectl to system PATH
sudo mv kubectl /usr/local/bin/

echo "✅ kubectl installed successfully!"

# Verify installation
kubectl version --client

