FROM centos:7 

RUN yum update -y && yum install -y unzip 

RUN mkdir /app

RUN curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 

RUN cd /app && unzip /tmp/shipping.zip

RUN yum install maven -y

RUN useradd roboshop

RUN cd /app && mvn clean package && mv target/shipping-1.0.jar shipping.jar

ENV CART_ENDPOINT=<CART-SERVER-IPADDRESS>:8080 DB_HOST=<MYSQL-SERVER-IPADDRESS>

EXPOSE 8080

CMD /bin/java -jar /app/shipping.jar