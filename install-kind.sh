#!/bin/bash

# Exit script if any command fails
set -e

KIND_VERSION="v0.22.0"

echo "🔹 Downloading KIND ${KIND_VERSION}..."

# Download KIND binary
curl -Lo kind "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64"

echo "🔹 Making KIND executable..."

# Make KIND executable
chmod +x kind

echo "🔹 Moving KIND to /usr/local/bin..."

# Move KIND binary to PATH
sudo mv kind /usr/local/bin/

echo "✅ KIND installed successfully!"

# Verify installation
kind version

