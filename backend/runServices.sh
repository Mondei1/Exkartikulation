#!/bin/bash

#set -e

# CHANGE IF YOU'RE USING DOCKER
docker='docker' # or docker

KEYCLOAK_DIR="$(dirname "$0")/services/keycloak"
CONTAINER_DB="exkart-db"
MAX_ATTEMPTS=32
ATTEMPT=0

print_bold() {
  local color="$1"
  local text="$2"
  bold=$(tput bold)
  normal=$(tput sgr0)
  color_code=$(tput setaf "$color") # Use tput setaf for color
  echo -e "${bold}${color_code}${text}${normal}"
}

print_bold 1 "Stop and delete services ..."
$docker compose down

# Delete keycloak instance
print_bold 1 "Remove $KEYCLOAK_DIR/instance ..."
rm -rfv "$KEYCLOAK_DIR/instance/*"

$docker compose up db -d

# Wait for the LDAP service to become available.
while true; do
  STATUS_DB=$($docker inspect -f '{{.State.Health.Status}}' "$CONTAINER_DB") # 2>/dev/null)

  if [[ "$STATUS_DB" == "healthy" ]]; then
    print_bold 1 "DB container '$CONTAINER_DB' is healthy. Import data ..."
    # Import users
    # Create keycloak scheme in database
    $docker exec -i $CONTAINER_DB /bin/sh -c "mariadb -u root -proot --skip-ssl << EOF
CREATE SCHEMA keycloak;
EOF"
    break
  else
     if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ];then
        print_bold 1 "Timeout waiting for container $CONTAINER_DB"
        exit 1
     fi

     ATTEMPT=$((ATTEMPT + 1))

     print_bold 1 "Container is not ready yet. Try again in a second ..."
     sleep 1
  fi
done

print_bold 1 "Bootstrap Keycloak ..."

$docker container run \
    --name keycloak_import \
    --rm \
    --user 0:0 \
    -e KC_DB=mariadb \
    -e KC_DB_PASSWORD=root \
    -e KC_DB_USERNAME=root \
    -e KC_DB_URL_HOST=db \
    -e KC_DB_SCHEMA=keycloak \
    -e KC_REALM=master \
    -e KC_USERS=skip \
    -e KC_DIR=/tmp/import/ \
    -v ./services/keycloak/instance:/opt/keycloak/data:Z \
    -v ./services/keycloak/master-realm.json:/tmp/import/master-realm.json:Z \
    --network backend_exkart-network \
    quay.io/keycloak/keycloak:latest \
    import --verbose

# Start all services
print_bold 1 "Start services ..."
$docker compose up -d

$docker compose logs -f