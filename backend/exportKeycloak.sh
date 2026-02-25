#!/bin/bash
# Only run this script if you want to persist your changes in Keycloak. This will override the
# current state and will make yours the new "well-known" configuration. Please commit your changes.

# CHANGE IF YOU'RE USING DOCKER
docker='docker' # or podman

EXPORT_DIR="$(dirname "$0")/services/keycloak"
echo "Export Keycloak configuration to $EXPORT_DIR ..."

$docker stop exkart-keycloak

# See https://www.keycloak.org/server/all-config for more info.
$docker container run \
    --name keycloak_export \
    --rm \
    --user 0:0 \
    --network backend_exkart-network \
    -e KC_DB=mariadb \
    -e KC_DB_PASSWORD=root \
    -e KC_DB_USERNAME=root \
    -e KC_DB_URL_HOST=db \
    -e KC_DB_SCHEMA=keycloak \
    -e KC_REALM=master \
    -e KC_USERS=realm_file \
    -e KC_DIR=/tmp/export/ \
    -v ./services/keycloak/instance:/opt/keycloak/data:Z \
    -v $EXPORT_DIR:/tmp/export:Z \
    quay.io/keycloak/keycloak:latest \
    export --verbose

$docker start exkart-keycloak