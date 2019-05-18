FROM centos:latest

########################################################
# Essential packages for remote debugging and login in
########################################################
RUN yum update -y \
    && yum install -y yum-utils openssh-server cmake gcc gcc-c++ make rsync vim less mc fuse boost-devel boost-static \
       systemd-devel fuse-devel fuse zlib-devel compat-glibc-headers \
#    && yum install -y gdb gdb-gdbserver
    && yum install -y centos-release-scl-rh \
    && yum --enablerepo=centos-sclo-rh install -y devtoolset-8-gdb devtoolset-8-gdb-gdbserver \
    && ln -s /opt/rh/devtoolset-8/root/usr/bin/gdb /usr/bin/gdb \
    && ln -s /opt/rh/devtoolset-8/root/usr/bin/gdbserver /usr/bin/gdbserver \
#
    && yum clean all && rm -rf /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd \
    && /usr/bin/ssh-keygen -A \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

## 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777
#
RUN useradd -ms /bin/bash dev && echo 'root:root' | chpasswd && echo 'dev:dev' | chpasswd
#
CMD ["/sbin/sshd", "-D"]
