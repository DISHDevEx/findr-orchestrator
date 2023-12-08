# Use a Node.js base image
FROM node:14

# Create app directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm install

# Install TypeScript globally
RUN npm install -g typescript

# Copy the application source code
COPY . .

# Compile TypeScript to JavaScript
RUN tsc

# The application's default port
EXPOSE 3000

# Command to run the application
CMD [ "node", "dist/app.js" ]
