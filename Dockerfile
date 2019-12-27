# Latest Ubuntu LTS 18.04 Bionic Beaver
# Ubuntu 18.04  #Bionic Beaner
# https://wiki.ubuntu.com/Releases
# Python 3.6, Ansible 2.9.2, Nornir 2.0
# Ansible 2.9.1 "Immigrant Song"
# https://launchpad.net/~ansible/+archive/ubuntu/ansible
# https://github.com/ansible/ansible/blob/stable-2.9/changelogs/CHANGELOG-v2.9.rst#id1
# cat /etc/issue
# apt-cache show ansible
# Bionic Immigrant

FROM ubuntu:18.04

LABEL maintainer="Claudia de Luna <claudia@indigowire.net>"

# Basic Updates Layer
RUN apt-get -y update && \
    apt-get -y update && \
    apt-get install -y apt-utils && \
    apt-get -y upgrade && \
    apt-get clean && \
    apt-get -qy autoremove --purge

# Python & Git Layer
RUN apt-get install -y python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources git python-pip

# Python3 Layer
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential libssl-dev libffi-dev python3-dev && \
    apt-get install -y python3-pip python3-venv python3-setuptools && \
    apt-get install -y python3-yaml python3-jinja2 python3-httplib2 && \
    apt-get clean && \
    apt-get -qy autoremove --purge

# Handy Network Utilities Layer
RUN apt-get install -y net-tools &&\
    apt-get install -y traceroute &&\
    apt-get install -y iputils-ping &&\
    apt-get install -y snmp &&\
    apt-get install -y snmp-mibs-downloader &&\
    apt-get install -y telnet &&\
    apt-get clean && \
    apt-get -qy autoremove --purge

# Ansible Layer 
RUN apt-get install -yq software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -q && \
    apt-get install -yq ansible=2.9.2-1ppa~bionic* && \
    apt-get clean && \
    apt-get -qy autoremove --purge

# Necessary Linux applications Layer
RUN apt-get install -y tree && \
    apt-get install -y nano && \
    apt-get install -y wget && \
    apt-get install -y vim && \
    apt-get install -y curl && \
    apt-get install -y openssh-client && \
    apt-get clean && \
    apt-get -qy autoremove --purge

# Documentation Layer
RUN apt-get -y update && \
    apt-get install -y pandoc && \
    apt-get install -y texlive && \
    pip install --upgrade pip && \
    pip3 install --upgrade pip && \
    apt-get clean && \
    apt-get -qy autoremove --purge

# Python Modules
RUN pip3 install argparse && \
    pip3 install requests && \
    pip3 install nornir && \
    pip2 install textfsm && \
    pip3 install textfsm && \
    pip3 install openpyxl && \
    pip3 install ciscoconfparse && \
    pip3 install netmiko && \
    pip3 install pandas && \
    pip3 install PyYAML && \
    pip3 install pyang && \
    pip3 install Pillow && \
    pip3 install pysnmp && \
    pip3 install ncclient && \
    pip3 install argparse && \
    pip3 install xlrd && \
    pip3 install virtualenv && \
    pip3 install --upgrade git+https://github.com/batfish/pybatfish.git && \
    pip3 install genie && \
    pip3 install pyats[full] && \
    pip3 install ipython && \
    apt-get clean && \
    apt-get -qy autoremove --purge

#
# Final Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get -qy autoremove

VOLUME /ansible

WORKDIR /ansible_local

EXPOSE 22

RUN git clone https://github.com/cldeluna/ansible2_4_base.git
RUN git clone https://github.com/cldeluna/cisco_aci.git
RUN git clone https://github.com/cldeluna/cisco_ios.git

RUN git config --global user.name "Bionic Immigrant"
RUN git config --global user.email "bionic@immigrant.com"
RUN ansible-galaxy install batfish.base --force 
RUN ansible-galaxy install ansible-network.network-engine --force

