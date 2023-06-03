FROM ubuntu:22.04
MAINTAINER Jeffrey Santoso

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABE4C7F993453843F0AEB8154D0BF748776FFB04 \
    && echo deb http://ppa.launchpad.net/iconnor/zoneminder-1.36/ubuntu jammy main > /etc/apt/sources.list.d/zoneminder.list 
    
RUN apt-get update ; apt-get dist-upgrade && apt-get autoremove ; apt-get autoclean;

RUN apt-get install -y \
        apt-utils \
        vim \
        libbz2-dev \
        libxml2-dev \
        libz-dev \
        libzip4 \
        libzip-dev \
        libmemcached-dev \
        unzip \
        iproute2 \
        iputils-ping \
        zip \
        gnupg



RUN DEBIAN_FRONTEND=noninteractive apt install --assume-yes zoneminder 
RUN a2enconf zoneminder
RUN a2enmod rewrite cgi

VOLUME /var/cache/zoneminder/events /var/cache/zoneminder/images /var/lib/mysql /var/log/zm

EXPOSE 80

COPY entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
