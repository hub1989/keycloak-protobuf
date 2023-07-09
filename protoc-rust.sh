#!/bin/bash

SERVICE_NAME=$1
RELEASE_VERSION=$2
USER_NAME=$3
EMAIL=$4
CARGO_TOKEN=$5

git config user.name "$USER_NAME"
git config user.email "$EMAIL"
git fetch --all && git checkout main
git pull

sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
mkdir -p rust/hub1989-protobuf-"${SERVICE_NAME}"/protos
# shellcheck disable=SC2035
cp "${SERVICE_NAME}"/*.proto "rust/hub1989-protobuf-${SERVICE_NAME}/protos"
# shellcheck disable=SC2164
cd rust/hub1989-protobuf-"${SERVICE_NAME}"
cargo login "${CARGO_TOKEN}"
cargo install cargo-bump
cargo bump "${RELEASE_VERSION}"

cargo build
cargo publish --no-verify --allow-dirty
