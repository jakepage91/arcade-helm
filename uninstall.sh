#!/bin/bash

# Set default release name
RELEASE_NAME="arcade"
NAMESPACE="default"

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
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "Uninstalling Arcade Helm chart..."
echo "Release name: $RELEASE_NAME"
echo "Namespace: $NAMESPACE"

# Uninstall the Helm chart
helm uninstall $RELEASE_NAME -n $NAMESPACE

echo "Uninstallation complete!" 