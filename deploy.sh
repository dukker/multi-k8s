docker build -t freddukker/multi-client:latest -t freddukker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t freddukker/multi-server:latest -t freddukker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t freddukker/multi-worker:latest -t freddukker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push freddukker/multi-client:latest
docker push freddukker/multi-server:latest
docker push freddukker/multi-worker:latest

docker push freddukker/multi-client:$SHA
docker push freddukker/multi-server:$SHA
docker push freddukker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=freddukker/multi-server:$SHA
kubectl set image deployments/client-deployment client=freddukker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=freddukker/multi-worker:$SHA
