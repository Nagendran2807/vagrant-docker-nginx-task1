#!/bin/bash
cat > /etc/yum.repos.d/docker.repo <<EOF
[DockerRepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
yum update -y
yum install docker -y
yum install docker-compose -y
systemctl enable docker
systemctl start docker
cat >> /etc/hosts <<EOF
127.0.0.1  myfirstpage.com
127.0.0.1  mysecondpage.com
127.0.0.1  mythirdpage.com
EOF

cd /home/vagrant/
cat >> Dockerfile <<EOF
From nginx:latest
MAINTAINER nagendranece28@gmail.com
RUN mkdir /etc/nginx/sites-available/
RUN rm -rf /etc/nginx/nginx.conf
COPY transfer/html/* /usr/share/nginx/html/
COPY transfer/sites-available/* /etc/nginx/sites-available/
#RUN /bin/cp nginx.conf /etc/nginx/nginx.conf
COPY transfer/nginx.conf /etc/nginx/
#VOLUME /etc/nginx/
#RUN "/etc/init.d/nginx start"
#RUN "/etc/init.d/nginx reload"
EXPOSE 80
EOF

docker build -t nginx:latest .

docker run -d --name=nginx_server -p 80:80 nginx:latest 

cat >> /etc/systemd/system/nginx-container.service <<EOF
[Unit]
Description=Vagrant Docker container for nginx webserver
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a nginx_server
ExecStop=/usr/bin/docker stop -t 2 nginx_server

[Install]
WantedBy=local.target
EOF

systemctl enable nginx-container.service 
systemctl start nginx-container.service
