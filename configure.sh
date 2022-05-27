unzip /fasion/fasion.zip -d /fasion
unzip /qserver/qserver.zip -d /qserver
rm -rf /fasion/fasion.zip
rm -rf /qserver/qserver.zip
cat << EOF > /qserver/config1.json
{
 "inbounds": [
    {
      "port": 23323,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$APP_ID",
            "alterId": 0
          }
        ],
        "disableInsecureEncryption": true
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$APP_PATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
chmod +x /qserver/qserver
envsubst '\$APP_ID,\$APP_PATH' < /qserver/config1.json > /qserver/config.json
/qserver/qserver -config /qserver/config.json &
echo /fasion/index.html
cat /fasion/index.html
rm -rf /etc/nginx/sites-enabled/default
/bin/bash -c "envsubst '\$PORT,\$APP_PATH' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
