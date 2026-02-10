

---

\# 🚀 Install kubectl & KIND using Shell Scripts (Linux)

This repository provides a \*\*DevOps-style, automated setup\*\* to install:

\- \*\*kubectl\*\* (Kubernetes CLI)  
\- \*\*KIND\*\* (Kubernetes IN Docker)

All installations are done using \*\*shell scripts (\`.sh\`)\*\* to ensure:  
\- Automation  
\- Repeatability  
\- Industry best practices

\---

\#\# 📁 Project Structure (Recommended)

\`\`\`text  
kind-setup/  
│  
├── install-kubectl.sh  
├── install-kind.sh  
├── kind-multinode.yaml  
└── README.md

---

## **🧩 Script 1: Install kubectl**

### **📄 `install-kubectl.sh`**

\#\!/bin/bash

\# Exit script immediately if any command fails  
set \-e

echo "🔹 Downloading latest kubectl binary..."

\# Download the latest stable kubectl version  
curl \-LO "https://storage.googleapis.com/kubernetes-release/release/$(curl \-s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

echo "🔹 Making kubectl executable..."

\# Give execute permission  
chmod \+x kubectl

echo "🔹 Moving kubectl to /usr/local/bin..."

\# Move kubectl to system PATH  
sudo mv kubectl /usr/local/bin/

echo "✅ kubectl installed successfully\!"

\# Verify installation  
kubectl version \--client

---

### **🧠 Explanation (Line by Line)**

* `#!/bin/bash`  
  ➝ Tells Linux to execute this script using the Bash shell  
* `set -e`  
  ➝ Stops the script immediately if any command fails (best practice)  
* `curl -LO ...`  
  ➝ Downloads the latest stable kubectl binary  
* `chmod +x kubectl`  
  ➝ Makes the kubectl binary executable  
* `sudo mv kubectl /usr/local/bin/`  
  ➝ Moves kubectl to a directory already in the system PATH  
* `kubectl version --client`  
  ➝ Confirms successful installation

---

### **▶️ Run Script**

chmod \+x install-kubectl.sh  
./install-kubectl.sh

---

## **🧩 Script 2: Install KIND**

### **📄 `install-kind.sh`**

\#\!/bin/bash

\# Exit script if any command fails  
set \-e

KIND\_VERSION="v0.22.0"

echo "🔹 Downloading KIND ${KIND\_VERSION}..."

\# Download KIND binary  
curl \-Lo kind "https://kind.sigs.k8s.io/dl/${KIND\_VERSION}/kind-linux-amd64"

echo "🔹 Making KIND executable..."

\# Make KIND executable  
chmod \+x kind

echo "🔹 Moving KIND to /usr/local/bin..."

\# Move KIND binary to PATH  
sudo mv kind /usr/local/bin/

echo "✅ KIND installed successfully\!"

\# Verify installation  
kind version

---

### **🧠 Explanation (Line by Line)**

* `KIND_VERSION="v0.22.0"`  
  ➝ Stores the KIND version in a variable for easy upgrades  
* `curl -Lo kind ...`  
  ➝ Downloads the KIND binary and renames it as `kind`  
* `chmod +x kind`  
  ➝ Allows execution of the KIND command  
* `sudo mv kind /usr/local/bin/`  
  ➝ Makes KIND accessible globally  
* `kind version`  
  ➝ Verifies KIND installation

---

### **▶️ Run Script**

chmod \+x install-kind.sh  
./install-kind.sh

---

## **🔎 Verify Installation**

kubectl version \--client  
kind version  
docker ps

---

## **🏁 Create a KIND Cluster (Single Node)**

kind create cluster  
kubectl get nodes

---

# **🔹 Create a Multi-Node KIND Cluster (Control Plane \+ Workers)**

KIND allows creating **multi-node Kubernetes clusters** using a configuration file.  
This helps you:

* Simulate real production clusters  
* Practice pod scheduling & scaling  
* Learn Kubernetes the industry way

---

## **📄 Step 1: Create KIND Cluster Config File**

Create a file named:

kind-multinode.yaml

### **📌 `kind-multinode.yaml`**

kind: Cluster  
apiVersion: kind.x-k8s.io/v1alpha4

nodes:  
\- role: control-plane  
\- role: worker  
\- role: worker

---

### **🧠 Explanation (Line by Line)**

* `kind: Cluster`  
  ➝ Defines that we are creating a KIND cluster  
* `apiVersion: kind.x-k8s.io/v1alpha4`  
  ➝ KIND configuration API version  
* `nodes:`  
  ➝ List of nodes in the cluster  
* `role: control-plane`  
  ➝ Main Kubernetes master node  
  ➝ Runs API Server, Scheduler, Controller Manager  
* `role: worker`  
  ➝ Worker nodes where application pods run

---

## **🚀 Step 2: Create Multi-Node KIND Cluster**

kind create cluster \\  
  \--name multinode-cluster \\  
  \--config kind-multinode.yaml

---

### **🧠 What Happens Internally?**

* KIND creates **Docker containers** as nodes  
* One Docker container \= one Kubernetes node  
* Networking is handled internally by Docker

---

## **🔍 Step 3: Verify Nodes**

kubectl get nodes

Expected output:

NAME                             STATUS   ROLES           AGE   VERSION  
multinode-cluster-control-plane  Ready    control-plane   2m    v1.xx.x  
multinode-cluster-worker         Ready    \<none\>          1m  
multinode-cluster-worker2        Ready    \<none\>          1m

---

## **🔍 Step 4: Verify Cluster Info**

kubectl cluster-info

---

## **🧪 Step 5: Test Pod Scheduling on Workers**

Create a test deployment:

kubectl create deployment nginx \--image=nginx

Scale the deployment:

kubectl scale deployment nginx \--replicas=3

Check pod placement:

kubectl get pods \-o wide

➡️ Pods will be distributed across worker nodes

---

## **🧹 Step 6: Delete Multi-Node Cluster**

kind delete cluster \--name multinode-cluster

---

## **🔥 Bonus: List All KIND Clusters**

kind get clusters

---

