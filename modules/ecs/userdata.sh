#!/bin/bash

mkdir -p /etc/graymeta
mkdir /data
touch /etc/graymeta/metafarm.env

cat >/etc/chrony.conf <<CHRONYEOL
server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
driftfile /var/lib/chrony/drift
makestep 1.0 3
rtcsync
logdir /var/log/chrony
CHRONYEOL

if [ -z "${proxy_endpoint}" ]
then
  echo "No proxy_endpoint set."
else
  echo "Setting proxy ${proxy_endpoint}"
  echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf

  mkdir -p /etc/systemd/system/docker.service.d
  echo "[Service]" > /etc/systemd/system/docker.service.d/http-proxy.conf
  echo "Environment=\"HTTP_PROXY=http://${proxy_endpoint}\""HTTPS_PROXY=http://${proxy_endpoint}\""NO_PROXY=localhost,127.0.0.1,169.254.169.254\"" >> /etc/systemd/system/docker.service.d/http-proxy.conf

  echo "HTTP_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
  echo "HTTPS_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
  echo "NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/ecs/ecs.config

  mkdir -p /etc/init/
  echo "env HTTP_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
  echo "env HTTPS_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
  echo "env NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/init/ecs.override

  echo "http_proxy=http://${proxy_endpoint}/" >> /etc/graymeta/metafarm.env
  echo "https_proxy=http://${proxy_endpoint}/" >> /etc/graymeta/metafarm.env
  echo "no_proxy=localhost,127.0.0.1,169.254.169.254" >> /etc/graymeta/metafarm.env
fi

echo "AWS_REGION=${region}" >> /etc/graymeta/metafarm.env
echo "termprotector_mode=docker" >> /etc/graymeta/metafarm.env
chmod 0400 /etc/graymeta/metafarm.env
chown graymeta:graymeta /etc/graymeta/metafarm.env

echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
systemctl enable chronyd
systemctl start chronyd
usermod -a -G docker graymeta
systemctl daemon-reload
systemctl restart docker
systemctl enable gm-termprotector
systemctl restart gm-termprotector
