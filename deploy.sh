docker build -t brianquigley/multi-client:latest -t brianquigley/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brianquigley/multi-server:latest -t brianquigley/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brianquigley/multi-worker:latest -t brianquigley/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brianquigley/multi-client:latest
docker push brianquigley/multi-server:latest
docker push brianquigley/multi-worker:latest

docker push brianquigley/multi-client:$SHA
docker push brianquigley/multi-server:$SHA
docker push brianquigley/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=brianquigley/multi-server:$SHA
kubectl set image deployments/client-deployment client=brianquigley/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brianquigley/multi-worker:$SHA
