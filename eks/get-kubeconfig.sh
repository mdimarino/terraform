#!/usr/bin/env bash

echo -e "\n=== cria kubeconfig ==="
KUBECONFIG=$(aws --profile acg-sandbox eks update-kubeconfig --name "eks-eksctl" --kubeconfig kubeconfig | awk '{ print $6 }')
echo 'execute: export KUBECONFIG=$(pwd)/kubeconfig'
