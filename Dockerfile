FROM debian:bullseye-slim

RUN apt-get -qq update && \
    apt-get -qq --no-install-recommends install gettext-base nginx fcgiwrap git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

RUN mkdir /srv/git

VOLUME ["/srv/git", "/var/log/nginx"]

COPY default.conf /etc/nginx/conf.d/

COPY gitconfig.template /etc/

COPY nginx.conf /etc/nginx/

RUN sed -i '35iserver_tokens off;' /etc/nginx/nginx.conf

COPY index.html /usr/share/nginx/html/

COPY 99_start.sh /etc/my_init.d/

ENV GIT_POSTBUFFER 1048576

CMD ["sh", "/etc/my_init.d/99_start.sh"]
