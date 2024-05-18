#!/usr/bin/env bash
# Sets up the web servers for the deployment of web_static.
# Install Nginx if not already installed
sudo apt update -y >/dev/null 2>&1
sudo apt install nginx -y

sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html
sudo chown -R ubuntu:ubuntu /data/

sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html
sudo ln -s -f /data/web_static/releases/test /data/web_static/current
printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location /redirect_me {
        return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default
#sudo sed -i '/listen 80 default_server/a location / hbnb_static {alias /data/web_static/current/;}' /etc/nginx/sites-available/default
#sudo  nginx -t
# Restart the nginx service
sudo service nginx restart
