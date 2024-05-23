#!/bin/bash

docker build -t fineken/web-app:latest -f web-app/dockerfile web-app/
docker push fineken/web-app:latest
kubectl apply -f k8s/web-app.yaml


docker build -t fineken/stats:latest -f stats-script/dockerfile stats-script/
docker push fineken/stats:latest
kubectl apply -f k8s/script.yaml

kubectl apply -f k8s/service.yaml
