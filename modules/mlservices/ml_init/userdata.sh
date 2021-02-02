#!/bin/bash

cat >/etc/chrony.conf <<CHRONYEOL
server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
driftfile /var/lib/chrony/drift
makestep 1.0 3
rtcsync
logdir /var/log/chrony
CHRONYEOL

cat >etc/systemd/system/docker-${service_name}-api.service <<DOCKERAPIEOL
[Unit]
Description=Daemon for ${service_name}-api
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill ${service_name}-api
ExecStartPre=-/usr/bin/docker rm  ${service_name}-api
ExecStart=/usr/bin/docker run \
    --net bridge \
    -m 0b \
    -e "FLASK_API_PORT=${api_port}" \
    -e "TFS_HOST=172.17.0.1" \
    -e "TFS_PORT=${tfs_port}" \
    -p ${api_port}:${api_port} \
    --log-driver=awslogs \
    --log-opt awslogs-group=${log_group} \
    --log-opt awslogs-stream=${service_name}-api-%H \
    --name ${service_name}-api \
    graymeta-${service_name}-api
ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-api
ExecStop=-/usr/bin/docker rm ${service_name}-api
[Install]
WantedBy=multi-user.target
DOCKERAPIEOL

cat >/etc/systemd/system/docker-${service_name}-tfs.service <<DOCKERTFSEOL
[Unit]
Description=Daemon for ${service_name}-tfs
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill ${service_name}-tfs
ExecStartPre=-/usr/bin/docker rm  ${service_name}-tfs
ExecStart=/usr/bin/docker run \
    --net bridge \
    -m 0b \
    -p ${tfs_port}:9000 \
    --log-driver=awslogs \
    --log-opt awslogs-group=${log_group} \
    --log-opt awslogs-stream=${service_name}-tfs-%H \
    --name ${service_name}-tfs \
    graymeta-${service_name}-tfs
ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-tfs
ExecStop=-/usr/bin/docker rm ${service_name}-tfs
[Install]
WantedBy=multi-user.target
DOCKERTFSEOL

chmod 0644 /etc/systemd/system/docker-${service_name}-api.service
chmod 0644 /etc/systemd/system/docker-${service_name}-tfs.service

if [ -z "${proxy_endpoint}" ]; then
    echo "No proxy_endpoint set."
else
    echo "export HTTP_PROXY=http://${proxy_endpoint}/" >>/etc/profile.d/proxy.sh
    echo "export HTTPS_PROXY=http://${proxy_endpoint}/" >>/etc/profile.d/proxy.sh
    echo "export NO_PROXY=169.254.169.254,localhost,127.0.0.1,/var/run/docker.sock" >>/etc/profile.d/proxy.sh
    source /etc/profile.d/proxy.sh
    echo "proxy=http://${proxy_endpoint}" >>/etc/yum.conf

    cat >/etc/systemd/system/docker.service.d/http-proxy.conf <<HTTPPROXYEOL
[Service]
Environment="HTTP_PROXY=http://${proxy_endpoint}" "HTTPS_PROXY=http://${proxy_endpoint}" "NO_PROXY=169.254.169.254,localhost,127.0.0.1,/var/run/docker.sock"
HTTPPROXYEOL

    chmod 0644 /etc/systemd/system/docker.service.d/http-proxy.conf

    cat >/var/awslogs/etc/proxy.conf <<PROXYEOL
HTTP_PROXY=http://${proxy_endpoint}
HTTPS_PROXY=http://${proxy_endpoint}
NO_PROXY=169.254.169.254
PROXYEOL

fi

sed -i 's/^metalink=/#metalink=/g' /etc/yum.repos.d/*
sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*
sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/*
growpart /dev/xvda 2
growpart /dev/nvme0n1 2
pvresize /dev/xvda2
pvresize /dev/nvme0n1p2
lvextend -l +100%FREE /dev/mapper/centos-root
xfs_growfs /dev/mapper/centos-root
systemctl enable chronyd
systemctl start chronyd
systemctl daemon-reload
systemctl restart docker
systemctl enable docker-${service_name}-api.service
systemctl restart docker-${service_name}-api.service
systemctl enable docker-${service_name}-tfs.service
systemctl restart docker-${service_name}-tfs.service
