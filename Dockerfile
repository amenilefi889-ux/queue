FROM eclipse-temurin:17-jre

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q -O activemq.tar.gz https://archive.apache.org/dist/activemq/5.17.3/apache-activemq-5.17.3-bin.tar.gz \
 && tar -xzf activemq.tar.gz \
 && rm activemq.tar.gz

RUN sed -i 's/127\.0\.0\.1/0.0.0.0/g' /apache-activemq-5.17.3/conf/jetty.xml

CMD ["/apache-activemq-5.17.3/bin/activemq", "console"]
