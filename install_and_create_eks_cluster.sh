#!/bin/bash

# EKSCTL Installation
echo "Installing eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
echo "eksctl installed successfully."
eksctl version

# Kubectl Installation
echo "Installing kubectl..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.4/2024-09-11/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
echo "kubectl installed successfully."

# Verify kubectl version
kubectl version --client

# Granting all users access to kubectl (adjust permissions if needed)
sudo chmod +x /usr/local/bin/kubectl
echo "kubectl permissions adjusted for all users."

# EKS Cluster Creation
CONFIG_FILE="eks.yaml"

# Check if the config file exists in the same directory
if [[ -f $CONFIG_FILE ]]; then
    echo "Creating EKS cluster using $CONFIG_FILE..."
    eksctl create cluster --config-file=$CONFIG_FILE
else
    echo "Config file $CONFIG_FILE not found in the current directory."
    exit 1
fi
