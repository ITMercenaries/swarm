docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer

#===> Nachine metrics, VMs ststs===
docker service create --name nexporter --mode global --network proxy \
  --mount "type=bind,source=/proc,target=/host/proc,ro=true" \
  --mount "type=bind,source=/,target=/rootfs,ro=true" \
  --mount "type=bind,source=/sys,target=/sys,ro=true" \
  prom/node-exporter:latest

#===> Contianer's stats
docker service create --name cadvisor \
  -p 8080:8080 \
  --mode global \
  --network proxy \
  --mount "type=bind,source=/,target=/rootfs,ro=true" \
  --mount "type=bind,source=/var/run,target=/var/run,ro=true" \
  --mount "type=bind,source=/sys,target=/sys,ro=true" \
  --mount "type=bind,source=/var/lib/docker,target=/var/lib/docker,ro=true" \
  google/cadvisor:v0.27.2

#Find Kibana container--> run curl http://cadvisor:8080/metrics
curl http://nexporter:9100/metrics

docker service create --name prometheus --network proxy -p 9090:9090 \
  --mount "type=bind,source=$PWD/prometheus.yml,target=/etc/prometheus/prometheus.yml \
  --mount "type=bind,source=/app/monitor,target=/prometheus" \
  prom/prometheus:v1.8.2

