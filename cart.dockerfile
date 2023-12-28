FROM centos:7 AS base

RUN yum update -y && yum install -y unzip

RUN mkdir /app

RUN curl L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

RUN cd /app && unzip /tmp/cart.zip

FROM node:18 as runtime

RUN useradd roboshop

RUN mkdir app 

COPY --from=base /app/* /app/

ENV REDIS_HOST=<REDIS-SERVER-IP> CATALOGUE_HOST=<CATALOGUE-SERVER-IP> CATALOGUE_PORT=8080

RUN cd /app && npm install

EXPOSE 8080

CMD [ "node" "/app/server.js"]