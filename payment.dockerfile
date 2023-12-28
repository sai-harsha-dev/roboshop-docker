FROM centos:7

RUN yum update -y && yum install -y unzip 

RUN mkdir /app

RUN curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

RUN cd /app && unzip /tmp/payment.zip

RUN yum install python36 gcc python3-devel -y

RUN useradd roboshop

RUN cd /app && pip3.6 install -r requirements.txt

ENV CART_HOST=<CART-SERVER-IPADDRESS> CART_PORT=8080  USER_HOST=<USER-SERVER-IPADDRESS> USER_PORT=8080 AMQP_HOST=<RABBITMQ-SERVER-IPADDRESS> AMQP_USER=roboshop AMQP_PASS=roboshop123

EXPOSE 8080

CMD /usr/local/bin/uwsgi --ini payment.ini 