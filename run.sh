#!/bin/bash

if [ -x "$(command -v docker)" ]; then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing..."
    curl -fsSL https://get.docker.com | sh
fi

mkdir -p /var/lib/tg_calc && touch /var/lib/tg_calc/data.json
docker pull hadish10/tg_calc
docker run -it -v /var/lib/tg_calc/data.json:/data.json --entrypoint "node" hadish10/tg_calc config.js
docker run -d -v /var/lib/tg_calc/data.json:/data.json --name tg_calc_bot --restart always --entrypoint "node" hadish10/tg_calc bot.js
docker run -d -v /var/lib/tg_calc/data.json:/data.json --name tg_calc_watcher --restart always hadish10/tg_calc

#docker build -t hadish10/tg_calc .
#docker stop tg_calc_watcher && docker rm tg_calc_watcher && docker stop tg_calc_bot && docker rm tg_calc_bot && docker rmi hadish10/tg_calc -f && curl -fsSL https://raw.githubusercontent.com/fokf255/tg_calc/main/run.sh -o run.sh && chmod +x run.sh && ./run.sh