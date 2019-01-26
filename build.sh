#!/bin/sh

set -eux

NFPM_VERSION="${NFPM_VERSION:-v0.9}"
NOMAD_VERSION="${NOMAD_VERSION:-0.8.7}"
NOMAD_URL="https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}"

cd build/

curl -sLO "${NOMAD_URL}_linux_amd64.zip"
curl -sLO "${NOMAD_URL}_SHA256SUMS"
curl -sLO "${NOMAD_URL}_SHA256SUMS.sig"

# Hashicorp signing key: 51852D87348FFC4C
# Hashicorp key fingerprint: 91A6 E7F8 5D05 C656 30BE F189 5185 2D87 348F FC4C
gpg --keyserver keyserver.ubuntu.com --recv 51852D87348FFC4C

# Verify the signature file is untampered.
gpg --verify "nomad_${NOMAD_VERSION}_SHA256SUMS.sig" "nomad_${NOMAD_VERSION}_SHA256SUMS"

# Verify the SHASUM matches the binary.
grep linux_amd64.zip "nomad_${NOMAD_VERSION}_SHA256SUMS" | shasum -a 256 -c -

unzip "nomad_${NOMAD_VERSION}_linux_amd64.zip"

cd ..

docker run --rm \
  -e NOMAD_VERSION="${NOMAD_VERSION}" \
  -v "${PWD}":/tmp/pkg \
  goreleaser/nfpm:"${NFPM_VERSION}" pkg --config /tmp/pkg/nomad.yml --target /tmp/pkg/build/nomad.rpm

# cleanup
#rm "nomad_${NOMAD_VERSION}_linux_amd64.zip" "nomad_${NOMAD_VERSION}_SHA256SUMS.sig" "nomad_${NOMAD_VERSION}_SHA256SUMS" nomad
