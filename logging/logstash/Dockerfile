FROM docker.elastic.co/logstash/logstash:5.6.3
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
USER logstash
COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf
COPY logstash.yml /usr/share/logstash/config/logstash.yml

