#!/bin/bash

SERVICE_NAME=$1
RELEASE_VERSION=$2
USER_NAME=$3
EMAIL=$4
REPO_NAME=$5

git config user.name "$USER_NAME"
git config user.email "$EMAIL"
git fetch --all && git checkout main
git pull

sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
# shellcheck disable=SC2155
export PATH="$PATH:$(go env GOPATH)/bin"
protoc --go_out=./golang --go_opt=paths=source_relative \
  --go-grpc_out=./golang --go-grpc_opt=paths=source_relative \
 ./"${SERVICE_NAME}"/*.proto
# shellcheck disable=SC2164
cd golang/"${SERVICE_NAME}"
go mod init \
  github.com/"${REPO_NAME}"/golang/"${SERVICE_NAME}" || true
go mod tidy
cd ../../
# shellcheck disable=SC2015
git add . && git commit -am "proto update" || true
git push origin HEAD:main
git tag -fa golang/"${SERVICE_NAME}"/"v${RELEASE_VERSION}" \
  -m "golang/${SERVICE_NAME}/v${RELEASE_VERSION}"
git push origin refs/tags/golang/"${SERVICE_NAME}"/v"${RELEASE_VERSION}"