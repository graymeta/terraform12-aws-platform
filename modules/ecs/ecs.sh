#!/bin/bash

mkdir -p /etc/systemd/system/docker.service.d
mkdir -p /etc/init/

if [ -z "${proxy_endpoint}" ]
then
  echo "No proxy_endpoint set."
else
  echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
  echo "Environment=\"HTTP_PROXY=http://${proxy_endpoint}\""HTTPS_PROXY=http://${proxy_endpoint}\""NO_PROXY=localhost,127.0.0.1,169.254.169.254\"" >> /etc/systemd/system/docker.service.d/http-proxy.conf
  echo "HTTP_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
  echo "HTTPS_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
  echo "env HTTP_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
  echo "env HTTPS_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
  echo "http_proxy=http://${proxy_endpoint}/" >> /etc/graymeta/metafarm.env
  echo "https_proxy=http://${proxy_endpoint}/" >> /etc/graymeta/metafarm.env
fi

echo "[Service]" > /etc/systemd/system/docker.service.d/http-proxy.conf
echo "NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/ecs/ecs.config
echo "env NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/init/ecs.override
echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
systemctl enable chronyd
systemctl start chronyd
mkdir /data
usermod -a -G docker graymeta
systemctl daemon-reload
systemctl restart docker
systemctl enable gm-termprotector
systemctl restart gm-termprotector

cat >/etc/chrony.conf <<CHRONYEOL
server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
driftfile /var/lib/chrony/drift
makestep 1.0 3
rtcsync
logdir /var/log/chrony
CHRONYEOL

cat >/etc/graymeta/metafarm.env <<METAFARMENV
echo "AWS_REGION=${region}
echo "no_proxy=localhost,127.0.0.1,169.254.169.254
echo "termprotector_mode=docker
METAFARMENV

chmod 0400 /etc/graymeta/metafarm.env
chown graymeta:graymeta /etc/graymeta/metafarm.env
