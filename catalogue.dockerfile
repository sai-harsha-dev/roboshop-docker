FROM centos:7 AS base

RUN yum update -y && yum install -y unzip

RUN mkdir /app

RUN curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

RUN cd /app && unzip /tmp/catalogue.zip

FROM node:18 as runtime

RUN useradd roboshop

RUN mkdir app 

COPY --from=base /app/* /app/

ENV MONGO=true MONGO_URL="mongodb://54.165.18.103:27017/catalogue"

RUN cd /app && npm install

EXPOSE 8080

CMD [ "node" "/app/server.js"]