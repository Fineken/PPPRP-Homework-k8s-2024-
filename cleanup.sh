#!/bin/bash

# Удаление всех деплойментов
kubectl delete deployment web-app-deployment
kubectl delete deployment web-app-deployment2
kubectl delete deployment stats-script-deployment
kubectl delete deployment stats-script-deployment2
kubectl delete deployment exporter-deployment

# Удаление всех сервисов
kubectl delete service web-app-service
kubectl delete service web-app-service2
kubectl delete service exporter-service

# Удаление Istio Gateway и VirtualService
kubectl delete gateway web-app-gateway2
kubectl delete virtualservice web-app2

# Удаление ServiceEntry для внешнего трафика
kubectl delete serviceentry worldtimeapi

# Удаление Prometheus Operator и связанных ресурсов
kubectl delete deployment prometheus-operator -n monitoring
kubectl delete service prometheus-operator -n monitoring
kubectl delete servicemonitor exporter-servicemonitor -n monitoring
kubectl delete prometheus prometheus -n monitoring
kubectl delete service prometheus -n monitoring

# Удаление пространства имен monitoring
kubectl delete namespace monitoring

# Удаление всех подов в пространстве имен default
kubectl delete pods --all -n default
