#!/bin/sh

# cron
cp -R common ../docker/Cron/src/.
cp -R database ../docker/Cron/src/.
cp -R network ../docker/Cron/src/.
cp main_cron.py ../docker/Cron/src/.

# pika
cp -R common ../docker/Pika/src/.
cp -R database ../docker/Pika/src/.
cp -R network ../docker/Pika/src/.

# webserver
cp -R common ../docker/WebSanic/src/.
cp -R database ../docker/WebSanic/src/.
cp -R network ../docker/WebSanic/src/.
cp -R web_app_sanic ../docker/WebSanic/src/.
