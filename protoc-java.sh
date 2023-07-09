#!/bin/bash

SERVICE_NAME=$1
RELEASE_VERSION=$2
USER_NAME=$3
EMAIL=$4
SETTINGS_FILE_PATH=$5

git config user.name "$USER_NAME"
git config user.email "$EMAIL"
git fetch --all && git checkout master

rm -rf java/"${SERVICE_NAME}"/src/main/protobuf
mkdir -p java/"${SERVICE_NAME}"/src/main/protobuf
# shellcheck disable=SC2035
cp "${SERVICE_NAME}"/*.proto "java/${SERVICE_NAME}/src/main/protobuf"

rm java/"${SERVICE_NAME}"/pom.xml
# shellcheck disable=SC2006
# shellcheck disable=SC2002
TEMPLATE=`cat java/"${SERVICE_NAME}"/"${SERVICE_NAME}"-template.xml | sed "s/{{VERSION}}/${RELEASE_VERSION}/g"`
echo "${TEMPLATE}" > java/"${SERVICE_NAME}"/pom.xml
# shellcheck disable=SC2164
cd java/"${SERVICE_NAME}"
mvn -B package --file pom.xml
mvn deploy -s "$SETTINGS_FILE_PATH" --file pom.xml
