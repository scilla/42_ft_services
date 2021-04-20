
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
kubectl apply -f srcs/namespace.yaml
kubectl apply -f srcs/metallb.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f srcs/balancer.yaml

docker build -t nginx srcs/nginx
docker build -t ftps srcs/ftps
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ftps.yaml
#kubectl expose deployment nginx --type=LoadBalancer --name=nginx --port=80 --port=443
#kubectl expose deployment ftps --type=LoadBalancer --name=ftps --port=21 --port=30021 --port=30020