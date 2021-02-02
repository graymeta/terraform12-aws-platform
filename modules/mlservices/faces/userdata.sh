#!/bin/bash

cat >/etc/chrony.conf <<CHRONYEOL
server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
driftfile /var/lib/chrony/drift
makestep 1.0 3
rtcsync
logdir /var/log/chrony
CHRONYEOL

cat >/etc/systemd/system/docker-${service_name}-data.service <<DOCKERDATAEOL
[Unit]
Description=Daemon for ${service_name}-data
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill ${service_name}-data
ExecStartPre=-/usr/bin/docker rm ${service_name}-data
ExecStart=/usr/bin/docker run \
    --net bridge \
    -m 0b \
    -e "GMFACES_DBCFG_HOST=${postgresendpoint}" \
    -e "GMFACES_DBCFG_READHOST=${postgresrendpoint}" \
    -e "GMFACES_DBCFG_PORT=${postgresport}" \
    -e "GMFACES_DBCFG_DBUSER=${postgresuser}" \
    -e "GMFACES_DBCFG_PASSWORD=${postgrespass}" \
    -e "GMFACES_DBCFG_NAME=${postgresdb}" \
    -e "GMFACES_STATSCFG_STATS_ENABLED=false" \
    -e "STATSD_BATCH_SIZE=100" \
    -p ${data_port}:10333 \
    --log-driver=awslogs \
    --log-opt awslogs-group=${log_group} \
    --log-opt awslogs-stream=faces-data-%H \
    --name ${service_name}-data \
    graymeta-${service_name}-data
ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-data
ExecStop=-/usr/bin/docker rm ${service_name}-data
[Install]
WantedBy=multi-user.target
DOCKERDATAEOL

cat >/etc/systemd/system/docker-${service_name}-sptag.service <<DOCKERSPTAGEOL
[Unit]
Description=Daemon for ${service_name}-sptag
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill ${service_name}-sptag
ExecStartPre=-/usr/bin/docker rm  ${service_name}-sptag
ExecStart=/usr/bin/docker run \
    --net bridge \
    -m 0b \
    -p 8000:8000 \
    --log-driver=awslogs \
    --log-opt awslogs-group=${log_group} \
    --log-opt awslogs-stream=faces-sptag-%H \
    --name ${service_name}-sptag \
    graymeta-${service_name}-sptag
ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-sptag
ExecStop=-/usr/bin/docker rm ${service_name}-sptag
[Install]
WantedBy=multi-user.target
DOCKERSPTAGEOL

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
    --log-opt awslogs-stream=faces-tfs-%H \
    --name ${service_name}-tfs \
    graymeta-${service_name}-tfs
ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-tfs
ExecStop=-/usr/bin/docker rm ${service_name}-tfs
[Install]
WantedBy=multi-user.target
DOCKERTFSEOL

chmod 0644 /etc/systemd/system/docker-${service_name}-data.service
chmod 0644 /etc/systemd/system/docker-${service_name}-sptag.service
chmod 0644 /etc/systemd/system/docker-${service_name}-tfs.service

if [ -z "${proxy_endpoint}" ]; then
    echo "No proxy_endpoint set."
else
    echo "Setting proxy ${proxy_endpoint}"

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

    cat >/var/awslogs/etc/proxy.conf <<PROXYCONFEOL
HTTP_PROXY=http://${proxy_endpoint}
HTTPS_PROXY=http://${proxy_endpoint}
NO_PROXY=169.254.169.254
PROXYCONFEOL
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
systemctl enable docker-${service_name}-data.service
systemctl restart docker-${service_name}-data.service
systemctl enable docker-${service_name}-api.service
systemctl restart docker-${service_name}-api.service
systemctl enable docker-${service_name}-sptag.service
systemctl restart docker-${service_name}-sptag.service
systemctl enable docker-${service_name}-tfs.service
systemctl restart docker-${service_name}-tfs.service
