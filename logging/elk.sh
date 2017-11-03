docker network create --driver overlay elk

docker service create --name elasticsearch --network elk  docker.elastic.co/elasticsearch/elasticsearch:5.6.3

docker service create --name kibana --network elk -e ELASTICSEARCH_URL=http://elasticsearch:9200 \
        --label com.df.notify=true  \
        --label com.df.distribute=true  \
        --label com.df.servicePath=/app,/bundles,/elasticsearch,/login,/logout,/ui,/plugins,/api \
        --label com.df.port=5601  \
       docker.elastic.co/kibana/kibana:5.6.3

docker service create --name logstash --mount type=bind,source=$PWD/logstash/conf,destination=/conf --network elk -e LOGSPOUT=ignore docker.elastic.co/logstash/logstash:5.6.3  logstash -f /conf/logstash.conf
docker service create --name logstash --network elk -e LOGSPOUT=ignore docker.elastic.co/logstash/logstash:5.6.3  
