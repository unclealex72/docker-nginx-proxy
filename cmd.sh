#!/bin/sh
set -e

/usr/sbin/nginx
/usr/local/bin/docker-gen -watch -only-exposed -notify \
    "/usr/sbin/nginx -s reload" /app/nginx.tmpl /etc/nginx/conf.d/default.conf
