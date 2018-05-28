FROM ubuntu
MAINTAINER Corbin Uselton <corbinu@decimal.io>

ENV TERM xterm

RUN apt-get update

RUN apt-get -yq install openssh-server; \
  mkdir -p /var/run/sshd; \
  mkdir /root/.ssh && chmod 700 /root/.ssh; \
  touch /root/.ssh/authorized_keys

COPY bin/* /usr/local/bin/
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["ssh-start"]
CMD ["ssh-server"]

# Nik customizations
COPY id_rsa.pub /tmp/nikskey.pub 

RUN cat /tmp/nikskey.pub >> /root/.ssh/authorized_keys 
RUN echo 'GatewayPorts yes' >> /etc/ssh/sshd_config

