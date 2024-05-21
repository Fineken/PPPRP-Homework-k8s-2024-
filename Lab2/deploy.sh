#!/bin/bash

# Установите переменные
fineken=your-dockerhub-username

# Сборка Docker-образов
echo "Building Docker images..."
docker build -t fineken/web-app:latest -f web-app/Dockerfile web-app/
docker build -t fineken/stats-script:latest -f stats-script/Dockerfile stats-script/

# Пуш Docker-образов на Docker Hub
echo "Pushing Docker images to Docker Hub..."
docker push fineken/web-app:latest
docker push fineken/stats-script:latest

# Применение манифестов Kubernetes
echo "Applying Kubernetes manifests..."
kubectl apply -f web-app-deployment2.yaml
kubectl apply -f stats-script-deployment2.yaml
kubectl apply -f external-service.yaml

# Проверка состояния подов
echo "Checking pod status..."
kubectl get pods

# Получение URL для web-app-service
echo "Getting service URL..."
minikube service web-app-service2 --url
