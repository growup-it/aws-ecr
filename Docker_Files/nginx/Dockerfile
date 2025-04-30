# docker build -t nginx:1.0 .
# docker images
# docker run -d -p 9090:80 --name webserver nginx:1.0 
# docker ps
# docker login
# docker tag nginx:1.0 <username>/<image-name>:tag
# docker push <username>/nginx:1.0
# https://devopscube.com/build-docker-image/


FROM ubuntu 
LABEL maintainer="contact@sample.com" 
RUN  apt-get -y update && apt-get -y install nginx
COPY files/default /etc/nginx/sites-available/default
COPY files/index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]