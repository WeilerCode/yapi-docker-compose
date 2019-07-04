FROM node:8.16-alpine as builder

WORKDIR /yapi/

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories \
    && apk update && apk add --no-cache git python make openssl tar gcc \
    && git clone --depth=1 https://github.com/YMFE/yapi.git vendors \
    && cd vendors \
    && npm install --production --registry https://registry.npm.taobao.org

FROM node:8.16-alpine as maker

WORKDIR /yapi/

RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org

COPY --from=builder /yapi/vendors /yapi/vendors
COPY config.json /yapi/config.json

EXPOSE 3000
