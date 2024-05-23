#!/bin/bash

minikube start

docker build -t web-app:latest web/
docker build -t script:latest script/

kubectl apply -f kubernetes/web-app.yaml
kubectl apply -f kubernetes/script.yaml

kubectl get pods

minikube service web-app-service --url
echo "done"