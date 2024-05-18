#!/usr/bin/env bash
# Sets up the web servers for the deployment of web_static.

# Install Nginx if not already installed
sudo apt update -y >/dev/null 2>&1
sudo apt install nginx -y >/dev/null 2>&1

# Create required director  if it doesn’t already exist

sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Create fake index.html file
sudo echo "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\t fake School_file\n\t</body>\n</html>" >/data/web_static/releases/test/index.html

# Create the symbolic link
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Change ownership of files and folders inside of /data folder
sudo chown -R ubuntu /data/
sudo chgrp -R ubuntu /data/
sudo echo -e "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>" >/data/web_static/releases/test/index.html

# Add alias to serve the content of /data/web_static/current to hbnb_static
sudo sed -i '/location \//i \tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
sudo  nginx -t
# Restart the nginx service
sudo service nginx restart
