#!/bin/sh

getent group nomad >/dev/null || groupadd -r nomad
getent passwd nomad >/dev/null || \
    useradd -r -g nomad -d /var/lib/nomad -s /sbin/nologin \
    -c "nomad scheduler service account" nomad
chown nomad:nomad /var/lib/nomad
exit 0
