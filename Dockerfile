FROM nginx:alpine
MAINTAINER mps299792458@gmail.com
MAINTAINER alex.jones@unclealex.co.uk


RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/${DOCKER_GEN_VERSION}/docker-gen-alpine-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz \
 && rm docker-gen-alpine-linux-amd64-${DOCKER_GEN_VERSION}.tar.gz

COPY nginx.tmpl /app/
WORKDIR /app/

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
COPY cmd.sh /sbin/cmd.sh
RUN chmod 755 /sbin/cmd.sh

ENV DOCKER_HOST unix:///var/run/docker.sock

VOLUME ["/etc/nginx/certs"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/sbin/cmd.sh"]
