FROM alpine:3.22.1 AS build

RUN mkdir -p /public /ssl

COPY . /public

RUN cp -r /public/ssl/* /ssl && rm -rf /public/ssl

FROM joseluisq/static-web-server:2.38.1

# 静态文件路径 /public
COPY --from=build /public   /public
COPY --from=build /ssl /ssl

# 默认首页 SERVER_INDEX_FILES=index.html

# 启用证书
ENV SERVER_HTTP2_TLS=true
ENV SERVER_HTTP2_TLS_CERT=/ssl/cert.pem
ENV SERVER_HTTP2_TLS_KEY=/ssl/key.pem

# 设置端口
ENV SERVER_PORT=5149

# 暴露端口
EXPOSE ${SERVER_PORT}

LABEL 镜像制作者="https://space.bilibili.com/17547201"
LABEL GitHub主页="https://github.com/Firfr/html5b-zh"
LABEL Gitee主页="https://gitee.com/firfe/html5b-zh"

# docker build -t firfe/html5b:2025.09.19 .
