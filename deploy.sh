docker build -t medsaidraoudh/multi-client:latest -t medsaidraoudh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t medsaidraoudh/multi-server:latest -t medsaidraoudh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t medsaidraoudh/multi-worker:latest -t medsaidraoudh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push medsaidraoudh/multi-client:latest
docker push medsaidraoudh/multi-worker:latest
docker push medsaidraoudh/multi-server:latest

docker push medsaidraoudh/multi-client:$SHA
docker push medsaidraoudh/multi-worker:$SHA
docker push medsaidraoudh/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=medsaidraoudh/multi-server:$SHA
kubectl set image deployments/client-deployment client=medsaidraoudh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=medsaidraoudh/multi-worker:$SHA