FROM ubuntu:16.04

#
# install NCALayer dependencies
#
RUN apt-get update && apt-get install -y unzip vim-common software-properties-common bsdmainutils expect

#
# install firefox
#
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    firefox \
    flashplugin-installer \
    unzip \
    ca-certificates

#
# install jre for NCALayer
# https://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
#
RUN apt-get install -y python-software-properties debconf-utils && add-apt-repository -y ppa:webupd8team/java && apt-get update && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && apt-get install -y oracle-java8-installer

#
# install certificates
#
COPY certs-install.sh /certs-install.sh
RUN /certs-install.sh && rm /certs-install.sh && apt-get install -y libnss3-tools

# install ncalayer
ADD "http://pki.gov.kz/images/NCALayer/ncalayer.zip" /ncalayer.zip
RUN unzip /ncalayer -d /ncalayer && rm /ncalayer.zip

#
# firefox stuff / X11 forwarding
#

# fix the missing sudo / sudoers.d
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

COPY mkprofile.sh /opt/mkprofile.sh
COPY container_startup.sh /opt/startup.sh

USER developer
ENV HOME /home/developer
VOLUME /user

ENTRYPOINT ["/opt/startup.sh"]
