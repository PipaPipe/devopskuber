kubectl delete -f ./service.yml
kubectl delete -f ./deploy-nginx.yml
kubectl apply -f ./deploy-nginx.yml
kubectl apply -f ./service.yml
kubectl get pods
kubectl get services
