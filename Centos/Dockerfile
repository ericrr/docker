
FROM centos/systemd

RUN yum install -y openssh-server  \
        && yum install -y openssh-clients  \
        && yum install -y net-tools \
        && yum install -y sudo \
        && yum install -y python.x86_64 \
        && yum install -y libselinux-python.x86_64

RUN ssh-keygen -q -f /etc/ssh/ssh_host_key -N '' -t rsa1 \
        && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
        && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
        && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521 \
        && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ecdsa -b 521

RUN echo "algadm  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
RUN groupadd algadm && adduser -m -d /var/lib/algadm -g algadm algadm && echo "algadm:123mudar" | chpasswd
RUN su - algadm -c "echo |mkdir ~/.ssh" \
        && chmod 0700 /var/lib/algadm/.ssh \
        && su - algadm -c "echo |echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDl8FDC1YwM69RG28MwXnbNV/P9y0Jg7k/mF6n8cNEnBMtQw8IE0UhwCOqOaPOUVhb5w3ECZC0dh1hCysPqTsjRkROpxpIsha26LiaUMUv5JyvKT1IVEsSr/Kum6cNzdfqz5dHmVzV7wC0ijYsKy9nBMf3idTsgyCYLeYOnrWpdZVPfv666GFmrXuYLrGnSN3dLeVvxH93zsv06by6iUKQ13T+BIbgx1xhmoiOBfhhxW+Wo05PYZPAKJGMZv2l4/RAkaRlHK7tnDUVRUu4CIsdreea7AfHmtvVffLNNShfsW3XphnIMSXycvER1qbkOqBEOPomHTYZHleJWbiZQCost algadm@rundk2.algar.lab > /var/lib/algadm/.ssh/authorized_keys" \
        && chmod 0744 /var/lib/algadm/.ssh/authorized_keys

EXPOSE 22

COPY ./start.sh /root

RUN /root/start.sh

CMD ["/usr/sbin/init"]