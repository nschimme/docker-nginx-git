#!/bin/sh

GIT_VARS='$GIT_POSTBUFFER'

envsubst "$GIT_VARS" < /etc/gitconfig.template > /etc/gitconfig

spawn-fcgi -u www-data -g www-data -M 0666 -s /var/run/fcgiwrap.socket -U www-data -G www-data /usr/sbin/fcgiwrap

nginx -g "daemon off;"
