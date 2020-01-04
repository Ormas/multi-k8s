docker build -t wisum/multi-client:latest -t wisum/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wisum/multi-server:latest -t wisum/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wisum/multi-worker:latest -t wisum/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wisum/multi-client:latest
docker push wisum/multi-server:latest
docker push wisum/multi-worker:latest

docker push wisum/multi-client:$SHA
docker push wisum/multi-server:$SHA
docker push wisum/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wisum/multi-server:$SHA
kubectl set image deployments/client-deployment client=wisum/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wisum/multi-worker:$SHA