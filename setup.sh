#base=https://github.com/docker/machine/releases/download/v0.16.0
#curl -L $base/docker-machine-$(uname -s)-$(uname -m) >docker-machine
#chmod +x docker-machine
#./docker-machine create --driver virtualbox default
#./docker-machine restart
#./docker-machine env default
#eval $(./docker-machine env default)

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl apply -f ./srcs/metallb.yaml
kubectl apply -f ./srcs/namespace.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f srcs/balancer.yaml