FROM ubuntu:latest

########################################################
# Essential packages for remote debugging and login in
########################################################

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y apt-utils openssh-server cmake build-essential gdb gdbserver rsync vim less mc fuse \
    libboost-system-dev libboost-program-options-dev libudev-dev libfuse-dev zlib1g-dev libpthread-stubs0-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Taken from - https://docs.docker.com/engine/examples/running_ssh_service/#environment-variables
# SSH login fix. Otherwise user is kicked off after login
RUN mkdir /var/run/sshd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777
#
RUN useradd -ms /bin/bash dev && echo 'dev:dev' | chpasswd && echo 'root:root' | chpasswd
#
CMD ["/usr/sbin/sshd", "-D"]