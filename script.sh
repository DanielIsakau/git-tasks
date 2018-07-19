#!/bin/bash

yum install epel-release nginx git java net-tools vim -y
if [ ! -f /opt/jenkins/bin/jenkins.war ]
then
	mkdir -p /opt/jenkins/bin/
	wget -P /opt/jenkins/bin/ http://mirrors.jenkins.io/war-stable/latest/jenkins.war
fi

cp /vagrant/jenkins.service /etc/systemd/
sed -n '38,57p;57q' /etc/nginx/nginx.conf > /etc/nginx/conf.d/jenkins.conf
sed -i '38, 57d' /etc/nginx/nginx.conf
sed -i '/location \/ {/a proxy_pass http:\/\/127.0.0.1:8080;' /etc/nginx/conf.d/jenkins.conf
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
systemctl enable nginx
systemctl start nginx

