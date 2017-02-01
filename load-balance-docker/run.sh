#!/bin/bash

# remove existing containers
docker stop apache1 apache2 haproxy
docker rm apache1 apache2 haproxy

# build and run 2 apache container
docker build -t devops-apache ./load-balance-docker/apache
docker run -d -it --name apache1 devops-apache
docker run -d -it --name apache2 devops-apache

# build and run haproxy container
docker build -t devops-haproxy ./load-balance-docker/haproxy
docker run -d -it -p 80:80 -p 81:81 --link apache1 --link apache2 --name haproxy devops-haproxy
