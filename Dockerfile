# Use the official Node.js image as a base
FROM node:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy your HTML files into the container
COPY . .

# Install the http-server package
RUN npm install -g http-server

# Expose the port the app runs on
EXPOSE 8080

# Command to run the HTTP server
CMD ["http-server", ".", "-p", "8080"]
