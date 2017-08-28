#!/bin/bash

# service account
kubectl create serviceaccount wso2svcacct
# persistent volume
kubectl apply -f volume/persistent-volumes.yaml


# databases
echo 'deploying databases ...'
kubectl apply -f rdbms/rdbms-persistent-volume-claim.yaml
kubectl apply -f rdbms/rdbms-service.yaml
kubectl apply -f rdbms/rdbms-deployment.yaml

sleep 20s
# analytics
echo 'deploying apim analytics ...'
kubectl apply -f apim-analytics/wso2apim-analytics-service.yaml
kubectl apply -f apim-analytics/wso2apim-analytics-1-service.yaml
kubectl apply -f apim-analytics/wso2apim-analytics-2-service.yaml
kubectl apply -f apim-analytics/wso2apim-analytics-1-deployment.yaml
sleep 30s
kubectl apply -f apim-analytics/wso2apim-analytics-2-deployment.yaml

sleep 1m
# apim
kubectl apply -f apim/wso2apim-mgt-volume-claim.yaml
kubectl apply -f apim/wso2apim-worker-volume-claim.yaml
kubectl apply -f apim/wso2apim-service.yaml
kubectl apply -f apim/wso2apim-manager-worker-service.yaml
kubectl apply -f apim/wso2apim-worker-service.yaml
echo 'deploying apim manager-worker ...'
kubectl apply -f apim/wso2apim-manager-worker-deployment.yaml
sleep 1m
echo 'deploying apim worker ...'
kubectl apply -f apim/wso2apim-worker-deployment.yaml
