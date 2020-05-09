#!/usr/bin/env bash

. ./.env
workdir=$(cd `dirname $0`; pwd)

# clone
git clone --depth=1 https://github.com/YMFE/yapi.git yapi/vendors

# create yapi config
front_cofig=${workdir}/yapi/config.json
echo "Create yapi config file: ${front_cofig}"
cat > ${front_cofig} << EOF
{
    "port": "3000",
    "adminAccount": "${YAPI_ADMIN_ACCOUNT}",
    "db": {
      "servername": "mongo",
      "DATABASE": "yapi",
      "port": 27017
    },
    "mail": {
      "enable": ${MAIL_ENABLE},
      "host": "${MAIL_HOST}",
      "port": ${MAIL_PORT},
      "from": "${MAIL_FROM}",
      "auth": {
        "user": "${MAIL_AUTH_USER}",
        "pass": "${MAIL_AUTH_PASS}"
      }
    }
}
EOF

docker-compose build
docker-compose run yapi ./init.sh
docker-compose up -d