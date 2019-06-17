docker build -t miksvas/multi-client:latest -t miksvas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t miksvas/multi-server:latest -t miksvas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t miksvas/multi-worker:latest -t miksvas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push miksvas/multi-client:latest
docker push miksvas/multi-server:latest
docker push miksvas/multi-worker:latest

docker push miksvas/multi-client:$SHA
docker push miksvas/multi-server:$SHA
docker push miksvas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=miksvas/multi-server:$SHA
kubectl set image deployments/client-deployment client=miksvas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=miksvas/multi-worker:$SHA
