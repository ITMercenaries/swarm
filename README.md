Docker Swarm mode DevOps
===

Docker swarm stack compose files for devops pipeline
* `Elasticsearch`:Database to store log data and query for it.
* `Logstash`: Log processor that ingests data from multiple sources and feeds it to Elasticsearch.
* `Logspout`: Logspout is deployed to all hosts to collect the logs from docker daemon and feed it to logstash.
* `Kibana`: Web UI to display Elasticseach data and provide query interface.

Run Instructions
---
Setup a Docker Swarm clustor with at least 3 nodes, from the swarm manager, deploy the stack with the following command,
```
docker stack deploy -c docker-stack.yml elk
```

Open Kibana in your browser with the following command:
```
open http://`docker-machine ip manager`
```
in Kibana, create new index 'logstash-* with `@timestamp` as the Time-field name.
