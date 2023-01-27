FROM centos:centos8

WORKDIR /home/podman

#WORKDIR /home/podman/.local/share/containers
ARG UID=1000
ARG GID=1000

RUN cd /etc/yum.repos.d/ \
    && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install epel-release \
   && yum update -y \
 #  && yum -y install "@Development Tools" \ #need?
  && yum install -y \
#   btrfs-progs-devel \
  conmon \
  containernetworking-plugins \
  containers-common \
  crun \
#   device-mapper-devel \
  git \
  glib2-devel \
  glibc-devel \
#   glibc-static \
  go \
  golang-github-cpuguy83-md2man \
#   gpgme-devel \
  iptables \
#   libassuan-devel \
  libgpg-error-devel \
  libseccomp-devel \
  libselinux-devel \
  make \
  pkgconfig

# RUN yum install wget -y \
#    && wget https://storage.googleapis.com/golang/getgo/installer_linux \
#    && chmod +x ./installer_linux

RUN groupadd --gid 1000 podman \
    && useradd --uid 1000 --gid podman --shell /bin/bash --create-home podman \
    && dnf install -y podman \
    && chown podman:podman -R /home/podman \
