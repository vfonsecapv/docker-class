# Pull base image.
FROM ubuntu:trusty

MAINTAINER victor.fonseca <victor.fonseca@sciensa.com>

RUN \
  sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start

# Define default command.
ENTRYPOINT ["bash", "/haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 81
