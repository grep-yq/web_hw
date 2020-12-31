FROM 192.168.242.91:5000/nginx
MAINTAINER Quan
RUN rm -rf /usr/share/nginx/html/index.html /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY static/* /usr/share/nginx/html/

CMD ["nginx","-g","daemon off;"]

