#!/bin/bash

# Установка Istio
echo "Installing Istio..."
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

istioctl install --set profile=demo -y

# Метки для автоматического внедрения sidecar
kubectl label namespace default istio-injection=enabled

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: istio-ingressgateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
EOF

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: deny-all
spec:
  hosts:
  - "*"
  gateways:
  - istio-ingressgateway
  http:
  - match:
      - uri:
          prefix: /
    route:
    - destination:
        host: 127.0.0.1
        port:
          number: 80
EOF

cd ..

echo "Building Docker images..."
docker build -t web-app:latest -f web-app/Dockerfile web-app/
docker build -t stats-script:latest -f stats-script/Dockerfile stats-script/
docker build -t exporter:latest -f exporter/Dockerfile exporter/

echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/web-app-deployment2.yaml
kubectl apply -f k8s/stats-script-deployment2.yaml
kubectl apply -f k8s/external-service.yaml
kubectl apply -f k8s/exporter-deployment.yaml
kubectl apply -f k8s/prometheus-operator.yaml
kubectl apply -f k8s/prometheus.yaml

echo "Restarting deployments..."
kubectl rollout restart deployment/web-app-deployment2
kubectl rollout restart deployment/stats-script-deployment2
kubectl rollout restart deployment/exporter-deployment

echo "Checking pod status..."
kubectl get pods

echo "Getting service URL..."
minikube service web-app-service2 --url
