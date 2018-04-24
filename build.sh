#!/usr/bin/env bash

set -eux
set -o pipefail

GPG_PASSFILE=(/dev/shm/pass.*)

printf 'DEBSIGN_PROGRAM="gpg --no-use-agent --no-tty --trusted-key 0x7D1110294E694719 --passphrase-file %s"\nDEBSIGN_KEYID=%s\n' "${GPG_PASSFILE[0]}" "0x7D1110294E694719" > "${HOME}/.devscripts"

srcdir=$(pwd)

export DEBFULLNAME="RJ Bergeron"
export DEBEMAIL="hewt1ojkif@gmail.com"

backportpackage -d xenial -u ppa:notarrjay/stretch-xen-on-xenial -y http://security.debian.org/debian-security/pool/updates/main/libv/libvirt/libvirt_3.0.0-4+deb9u3.dsc
