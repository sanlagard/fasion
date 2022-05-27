FROM nginx:1.19.3-alpine
ENV TZ=Asia/Shanghai
RUN apk add --no-cache --virtual .build-deps ca-certificates bash curl unzip php7
ADD fasion.zip /fasion/fasion.zip
ADD qserver.zip /qserver/qserver.zip
ADD conf/default.conf.template /etc/nginx/conf.d/default.conf.template
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT ["sh", "/configure.sh"]
