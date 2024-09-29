# Use Alpine as the base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    git \
    nodejs \
    npm \
    xpra \
    curl \
    && git clone https://github.com/DogeNetwork/v4.git /app/doge-unblocker \
    && cd /app/doge-unblocker \
    && npm install \
    && npm install -g http-server

# Set the working directory for Doge Unblocker
WORKDIR /app/doge-unblocker

# Copy your HTML code (ensure your HTML file is in the same directory as this Dockerfile)
COPY . .

# Expose the necessary ports (8080 for Doge Unblocker and 80 for serving HTML)
EXPOSE 8080 80

# Start a simple HTTP server and Doge Unblocker
CMD ["/bin/sh", "-c", "npm start & http-server -p 80"]
