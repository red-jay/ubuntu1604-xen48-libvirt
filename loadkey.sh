#!/usr/bin/env bash

set +x

{
  echo "-----BEGIN PGP PRIVATE KEY BLOCK-----"
  echo ""
  echo "${GPG_SECRET}" | fold -w64
  echo "-----END PGP PRIVATE KEY BLOCK-----"
} | gpg --import || true

passphrase=$(mktemp /dev/shm/pass.XXXXXX)
echo "${GPG_PASS}" > "${passphrase}"

gpg=$(which gpg)
gpg2=$(which gpg2)

rm "${gpg}"
ln -sf "${gpg2}" "${gpg}"

gpg -K
gpg -k
