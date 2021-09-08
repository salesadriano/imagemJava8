FROM debian:10

WORKDIR /code

ADD sources.list /etc/apt

RUN apt -y update && \ 
    apt -y install git \
          apt-transport-https \
          ca-certificates \
          wget \
          dirmngr \
          ntp \
          cron \
          gnupg software-properties-common  \
          unzip \
          gettext \
          mutt \ 
          sshpass && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt -y update && \
    apt -y remove libgcc-8-dev && \
    apt -y install adoptopenjdk-8-hotspot && \
    apt -y autoremove && \
    ln -sf /usr/share/zoneinfo/America/Rio_Branco /etc/localtime && \
    mkdir -p ~/.mutt/cache/headers && \
    mkdir ~/.mutt/cache/bodies && \
    touch ~/.mutt/certificates && \
    touch ~/.mutt/muttrc 

ADD start.sh /00-start.sh

RUN chmod 755 /00-start.sh

CMD ["/00-start.sh"]

