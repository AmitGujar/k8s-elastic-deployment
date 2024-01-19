#! /bin/bash

namespace="elastic-deployment"

kubectl delete deployment es-amundsen -n $namespace

kubectl delete ing elastic-ingress -n $namespace

kubectl delete ns elastic-deployment