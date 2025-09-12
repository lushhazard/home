!#/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 <port>"
  exit 1
fi

PORT="$1"

curl -s "http://localhost:8080/api/v2/app/setPreferences" -d 'json={"listen_port": "'"$PORT"'"}'
echo "Updated qBittorrent port: $PORT"
