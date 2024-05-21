#!/bin/bash


DOCKER_USERNAME=fineken

echo "Building Docker images..."
docker build -t $DOCKER_USERNAME/web-app:latest -f web-app/Dockerfile web-app/
docker build -t $DOCKER_USERNAME/stats-script:latest -f stats-script/Dockerfile stats-script/

echo "Pushing Docker images to Docker Hub..."
docker push $DOCKER_USERNAME/web-app:latest
docker push $DOCKER_USERNAME/stats-script:latest

echo "Applying Kubernetes manifests..."
kubectl apply -f web-app-deployment.yaml
kubectl apply -f stats-script-deployment.yaml

echo "Checking pod status..."
kubectl get pods

echo "Getting service URL..."
minikube service web-app-service --url
