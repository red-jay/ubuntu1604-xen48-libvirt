#!/usr/bin/env bash

set -eux
set -o pipefail

GPG_PASSFILE=(/dev/shm/pass.*)

printf 'DEBSIGN_PROGRAM="gpg --no-use-agent --no-tty --trusted-key 0x7D1110294E694719 --passphrase-file %s"\nDEBSIGN_KEYID=%s\n' "${GPG_PASSFILE[0]}" "0x7D1110294E694719" > "${HOME}/.devscripts"

srcdir=$(pwd)

export DEBFULLNAME="RJ Bergeron"
export DEBEMAIL="hewt1ojkif@gmail.com"

libvirt_dsc='http://security.debian.org/debian-security/pool/updates/main/libv/libvirt/libvirt_3.0.0-4+deb9u3.dsc'
lv="${libvirt_dsc##*/}"
dv=${lv##*-}
dv=${dv%.dsc}
ov=${lv%-$dv*}
upath=${libvirt_dsc%$lv}

curl -LO "${libvirt_dsc}"
curl -LO "${upath}${ov}.orig.tar.xz"
curl -LO "${upath}${ov}-${dv}.debian.tar.xz"

cat "${lv}"

dscverify "${lv}"

cat "${lv}" | iconv -f UTF8//IGNORE -t ASCII//TRANSLIT | sed -e 's/-----BEGIN PGP SIGNED MESSAGE-----//' -e 's/Hash:.*//' -e '/-----BEGIN PGP SIGNATURE-----/,/-----END PGP SIGNATURE-----/d' -e '/^$/d' > "${lv}.tmp"

cat "${lv}.tmp"

# backportpackage -d xenial -u ppa:notarrjay/stretch-xen-on-xenial -y "${lv}"
