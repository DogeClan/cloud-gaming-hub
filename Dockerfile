# Use the official Ubuntu image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    nginx \
    git \
    curl \
    build-essential \
    python3-pip

# Clone the LunarSync repository
RUN git clone https://github.com/smartfoloo/lunarsync.git /opt/lunarsync

# Navigate to the LunarSync directory and install dependencies
WORKDIR /opt/lunarsync
RUN pip3 install -r requirements.txt

# Copy your HTML files into the Nginx directory
COPY . /usr/share/nginx/html

# Create the Nginx configuration file
RUN echo 'worker_processes 1;' > /etc/nginx/nginx.conf && \
    echo 'events { worker_connections 1024; }' >> /etc/nginx/nginx.conf && \
    echo 'http {' >> /etc/nginx/nginx.conf && \
    echo '    server {' >> /etc/nginx/nginx.conf && \
    echo '        listen 80;' >> /etc/nginx/nginx.conf && \
    echo '        location / {' >> /etc/nginx/nginx.conf && \
    echo '            root /usr/share/nginx/html;' >> /etc/nginx/nginx.conf && \
    echo '            index index.html;' >> /etc/nginx/nginx.conf && \
    echo '        }' >> /etc/nginx/nginx.conf && \
    echo '    }' >> /etc/nginx/nginx.conf && \
    echo '}' >> /etc/nginx/nginx.conf

# Expose the port for Nginx server
EXPOSE 80

# Start Nginx and LunarSync
CMD nginx && python3 /opt/lunarsync/lunarsync.py
