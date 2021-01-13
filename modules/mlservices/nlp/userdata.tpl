#cloud-config
package_upgrade: false
runcmd:
- sed -i 's/^metalink=/#metalink=/g' /etc/yum.repos.d/*
- sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*
- sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/*
- growpart /dev/xvda 2
- growpart /dev/nvme0n1 2
- pvresize /dev/xvda2
- pvresize /dev/nvme0n1p2
- lvextend -l +100%FREE /dev/mapper/centos-root
- xfs_growfs /dev/mapper/centos-root
- systemctl enable chronyd
- systemctl start chronyd
- systemctl daemon-reload
- systemctl restart docker
- systemctl enable docker-${service_name}-api.service
- systemctl restart docker-${service_name}-api.service
write_files:
-   content: |
        server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
        driftfile /var/lib/chrony/drift
        makestep 1.0 3
        rtcsync
        logdir /var/log/chrony
    path: /etc/chrony.conf
-   content: |
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
            -e "STATSD_BATCH_SIZE=100" \
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
    path: /etc/systemd/system/docker-${service_name}-api.service
    permissions: '0644'
