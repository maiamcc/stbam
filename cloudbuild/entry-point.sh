#!/usr/bin/env sh

set -ex

syslog-ng

nginx

tail -f /var/log/messages
