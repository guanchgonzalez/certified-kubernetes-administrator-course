#!/bin/bash


###  Installing a Pod network add-on  ###################

#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version --output=yaml | grep gitVersion | tail -1 | awk '{print $NF}')"
kubectl apply -f "https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml"

