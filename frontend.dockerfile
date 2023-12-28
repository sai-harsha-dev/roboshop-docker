FROM centos:7 AS base 

RUN yum install -y unzip

RUN mkdir /app

RUN curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

RUN  unzip /tmp/frontend.zip -d /app

FROM nginx:stable-alpine-slim as runtime 

COPY --from=base /app/* /usr/share/nginx/html/

COPY roboshop.conf /etc/nginx/default.d

