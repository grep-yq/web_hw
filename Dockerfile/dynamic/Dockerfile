FROM 192.168.242.91:5000/tomcat:9.0-jdk13-openjdk-oracle
MAINTAINER Quan

RUN mkdir -p /usr/local/tomcat/data
COPY dynamic.war /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]


