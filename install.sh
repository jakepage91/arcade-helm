#!/bin/bash

# Set default release name
RELEASE_NAME="arcade"
NAMESPACE="default"
MINIKUBE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -n|--name)
      RELEASE_NAME="$2"
      shift
      shift
      ;;
    -ns|--namespace)
      NAMESPACE="$2"
      shift
      shift
      ;;
    --minikube)
      MINIKUBE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "Installing Arcade Helm chart..."
echo "Release name: $RELEASE_NAME"
echo "Namespace: $NAMESPACE"

# Check if minikube is running if --minikube flag is set
if [ "$MINIKUBE" = true ]; then
  echo "Checking if Minikube is running..."
  if ! minikube status > /dev/null 2>&1; then
    echo "Minikube is not running. Starting Minikube..."
    minikube start
  else
    echo "Minikube is already running."
  fi
fi

# Create namespace if it doesn't exist
kubectl get namespace $NAMESPACE > /dev/null 2>&1 || kubectl create namespace $NAMESPACE

# Install the Helm chart
helm install $RELEASE_NAME . \
  --namespace $NAMESPACE \
  --create-namespace

echo "Installation complete!"
echo "To check the status of your deployment, run:"
echo "  kubectl get pods -n $NAMESPACE"
echo "To access the Arcade Engine API, run:"
echo "  kubectl port-forward -n $NAMESPACE svc/$RELEASE_NAME-engine 9099:9099"

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/instance=$RELEASE_NAME -n $NAMESPACE --timeout=300s

echo "All pods are ready! You can now access the Arcade Engine API." 