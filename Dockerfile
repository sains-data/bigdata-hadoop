# Langkah 1: Base Image
FROM ubuntu:24.04
LABEL key="sainsdata-itera"

# Langkah 2: Install Dep
RUN apt-get update && apt-get -y install sudo adduser
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

# Langkah 3: Perbarui APT
RUN sudo apt-get -y install software-properties-common
RUN sudo add-apt-repository ppa:openjdk-r/ppa
RUN sudo apt-get update

# Langkah 4: Install Java
RUN apt-get -y install openjdk-8-jdk 
RUN ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64/ /usr/lib/jvm/java-1.8.0

# Langkah 5: Utility Tools
RUN apt -y install vim
RUN apt -y install nano
RUN apt -y install wget tar sudo rsync
RUN sudo apt-get update
RUN sudo apt-get -y install apache2
RUN sudo apt-get -y install tree

# Setup sock proxy
RUN apt-get install -y  openssh-server

# passwordless ssh
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 755 /root && chmod 700 /root/.ssh
RUN passwd --unlock root

# Langkah 6: Copy hadoop tarball and extract
COPY hadoop-3.4.1.tar.gz /hadoop-3.4.1.tar.gz
RUN tar -xvzf /hadoop-3.4.1.tar.gz -C /
RUN ln -sf /hadoop-3.4.1 /hadoop

RUN  apt-get -y clean all && rm -rf /tmp/* /var/tmp/* 

# Langkah 7: Copy configuration files and bootstrap script
RUN mkdir /conf
COPY core-site.xml /conf/core-site.xml
COPY hdfs-site.xml /conf/hdfs-site.xml
COPY hadoop-env.sh /conf/hadoop-env.sh

COPY bootstrap.sh /bootstrap.sh

# Langkah 8: Create Users
RUN sudo addgroup hadoop
RUN sudo adduser --ingroup hadoop hadoop

# HDFS ports
EXPOSE 1004 1006 8020 9866 9867 9870 9864 50470 9000 50070 9870

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888

# SOCKS port
EXPOSE 1180

# HDFS datnode
EXPOSE 9866

