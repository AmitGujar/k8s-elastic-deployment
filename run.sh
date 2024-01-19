#!/bin/bash

# ! warning - make sure you have created storage account with custom file share & secret for the same.
# ! elastic search deployment needs minimum 16gb ram.

upgrade_ingress() {
    echo "please wait while upgrading nginx..."
    helm upgrade --install ingress-nginx ingress-nginx \
        --repo https://kubernetes.github.io/ingress-nginx \
        --namespace public-ingress \
        --set controller.service.externalTrafficPolicy=Local \
        --set tcp.9200="elastic-deployment/es-amundsen-service:9200" \
        --set tcp.9300="elastic-deployment/es-amundsen-service:9300"
}
#upgrade_ingress

deploy() {
    echo "deploying elastic search...."
    kubectl apply -f deployment.yml

    sleep 5

    echo "update the es.akstest.tech dns record to this ip..."
    kubectl get svc -n public-ingress

    sleep 20

    echo "deploying ingress....."
    kubectl apply -f ingress.yml
}
deploy
