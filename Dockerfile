# Use the official Node.js image as a base
FROM node:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy your HTML files into the container
COPY . .

# Install the http-server package and mitmproxy
RUN npm install -g http-server && \
    apt-get update && \
    apt-get install -y mitmproxy && \
    apt-get clean

# Expose the ports for both http-server and mitmproxy
EXPOSE 8080 8081

# Create a script to start both servers
RUN echo '#!/bin/sh\nmitmdump --mode transparent --showhost --listen-port 8081 &\nhttp-server . -p 8080' > start.sh && \
    chmod +x start.sh

# Start the script
CMD ["./start.sh"]
