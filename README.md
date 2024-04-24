# PREREQUISITES 
4GB RAM
10GB HDD FREESPACE

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

sudo usermod -aG docker $USER && newgrp docker
minikube start --vm-driver=docker
```
Check if ok! LoadBalancer not working

# AUX for driver none
```
sudo apt install conntrack

exit
```
Check version of minilube in adjust as needed 
```
VERSION="v1.32.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz


wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.12/cri-dockerd-0.3.12.amd64.tgz
sudo tar zxvf cri-dockerd-0.3.12.amd64.tgz -C /usr/local/bin
rm -f cri-dockerd-0.3.12.amd64.tgz

sudo sysctl fs.protected_regular=0
sudo minikube start --vm-driver=none --force
```
# NOTES
```
sudo swapoff -a

minikube start --vm-driver=docker
;; sudo minikube start --vm-driver=none

minikube status
eval $(minikube docker-env)

sudo docker build -t nginx-devops .
minikube image load nginx-devops

kubectl apply -f deploy-nginx.yml

kubectl logs nginx-devops-xxxxxx
kubectl exec --stdin --tty nginx-devops-7b9586c9c8-4kgnb -- /bin/sh

kubectl apply -f service.yml
kubectl port-forward nginx-devops-7b656fff7f-ssmvw 12345:80 --address=0.0.0.0

;; will forward to first pod of service (will not loadbalance)
kubectl port-forward service/service-devops 12345:12345 --address=0.0.0.0

kubectl get pods --output=wide
kubectl get services
minikube service list

;; will forward to minikube cluster service (will loadbalance, but no external connectivity)
minikube tunnel

kubectl get deployment -w
kubectl get events -w

kubectl delete -f service.yml
kubectl delete -f deploy-nginx.yml

./restart.sh

sudo kubectl get services

NAME             TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)          AGE
kubernetes       ClusterIP      10.96.0.1       <none>         443/TCP          37m
service-devops   LoadBalancer   10.110.197.37   100.100.0.71   1234:31708/TCP   44s

curl 100.100.0.71:1234

<!DOCTYPE html>
<html>
<head>
<title>DevOps Course 2024</title>
</head>
<body>
DevOps Course 2024!
</body>
</html>
```