#!/bin/bash


echo "Building Docker images..."
docker build -t fineken/web-app:latest -f web-app/Dockerfile web-app/
docker build -t fineken/stats-script:latest -f stats-script/Dockerfile stats-script/

echo "Pushing Docker images to Docker Hub..."
docker push fineken/web-app:latest
docker push fineken/stats-script:latest

echo "Applying Kubernetes manifests..."
kubectl apply -f web-app-deployment2.yaml
kubectl apply -f stats-script-deployment2.yaml
kubectl apply -f external-service.yaml

echo "Checking pod status..."
kubectl get pods

echo "Getting service URL..."
minikube service web-app-service2 --url
