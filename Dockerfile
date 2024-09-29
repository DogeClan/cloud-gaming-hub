# Use the official Nginx image
FROM nginx:latest

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy your HTML files into the Nginx directory
COPY . .

# Create the Nginx configuration file
RUN echo 'worker_processes 1;' > /etc/nginx/nginx.conf && \
    echo 'events { worker_connections 1024; }' >> /etc/nginx/nginx.conf && \
    echo 'http {' >> /etc/nginx/nginx.conf && \
    echo '    server {' >> /etc/nginx/nginx.conf && \
    echo '        listen 80;' >> /etc/nginx/nginx.conf && \
    echo '' >> /etc/nginx/nginx.conf && \
    echo '        location / {' >> /etc/nginx/nginx.conf && \
    echo '            root   /usr/share/nginx/html;' >> /etc/nginx/nginx.conf && \
    echo '            index  index.html index.htm;' >> /etc/nginx/nginx.conf && \
    echo '            try_files $uri $uri/ =404;' >> /etc/nginx/nginx.conf && \
    echo '        }' >> /etc/nginx/nginx.conf && \
    echo '' >> /etc/nginx/nginx.conf && \
    echo '        # Forward Proxy Configuration' >> /etc/nginx/nginx.conf && \
    echo '        location /proxy/ {' >> /etc/nginx/nginx.conf && \
    echo '            resolver 8.8.8.8;  # Use Google DNS' >> /etc/nginx/nginx.conf && \
    echo '            set $target $arg_url;  # Get the target URL from the query string' >> /etc/nginx/nginx.conf && \
    echo '            proxy_pass http://$target;  # Forward the request to the target' >> /etc/nginx/nginx.conf && \
    echo '            proxy_set_header Host $host;' >> /etc/nginx/nginx.conf && \
    echo '            proxy_set_header X-Real-IP $remote_addr;' >> /etc/nginx/nginx.conf && \
    echo '            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' >> /etc/nginx/nginx.conf && \
    echo '            proxy_set_header X-Forwarded-Proto $scheme;' >> /etc/nginx/nginx.conf && \
    echo '        }' >> /etc/nginx/nginx.conf && \
    echo '    }' >> /etc/nginx/nginx.conf && \
    echo '}' >> /etc/nginx/nginx.conf

# Expose the port for the Nginx server
EXPOSE 80

# Start Nginx (default command)
CMD ["nginx", "-g", "daemon off;"]
