FROM python:2.7

RUN apt-get update \
    && apt-get upgrade -yq \
    && apt-get install -yq \
      git \
      software-properties-common \
    && echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
    && apt-get update \
    && apt-get install -yq \
      ansible \
    && apt-get clean \
    && rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

COPY docker/rootfs/etc/ansible /etc/ansible
COPY playbooks /opt/ansible/playbooks
COPY templates /opt/ansible/templates

WORKDIR /opt/ansible

CMD ["ansible-playbook"]
