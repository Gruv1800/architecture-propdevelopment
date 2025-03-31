#!/bin/bash

# Создание пользователя dev-user
echo "Создание пользователя dev-user..."
openssl genrsa -out dev-user.key 2048
openssl req -new -key dev-user.key -out dev-user.csr -subj "/CN=dev-user/O=dev_reader"
openssl x509 -req -in dev-user.csr -CA /Users/gruv1800/.minikube/ca.crt -CAkey /Users/gruv1800/.minikube/ca.key -CAcreateserial -out dev-user.crt -days 365
kubectl config set-credentials dev-user --client-certificate=dev-user.crt --client-key=dev-user.key
kubectl config set-context dev-user-context --cluster=docker-desktop --user=dev-user

# Создание пользователя monitoring-user
echo "Создание пользователя monitoring-user..."
openssl genrsa -out monitoring-user.key 2048
openssl req -new -key monitoring-user.key -out monitoring-user.csr -subj "/CN=monitoring-user/O=monitoring_reader"
openssl x509 -req -in monitoring-user.csr -CA /Users/gruv1800/.minikube/ca.crt -CAkey /Users/gruv1800/.minikube/ca.key -CAcreateserial -out monitoring-user.crt -days 365
kubectl config set-credentials monitoring-user --client-certificate=monitoring-user.crt --client-key=monitoring-user.key
kubectl config set-context monitoring-user-context --cluster=docker-desktop --user=monitoring-user

echo "Пользователи успешно созданы!"