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
    echo '        # Example of a proxy pass to an external service (adjust as needed)' >> /etc/nginx/nginx.conf && \
    echo '        location /proxy/ {' >> /etc/nginx/nginx.conf && \
    echo '            proxy_pass http://example.com;  # Replace with the actual URL you want to proxy' >> /etc/nginx/nginx.conf && \
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
