# Base image: Node 16
FROM node:16

# Install dependencies for Homebrew
RUN apt-get update && apt-get install -y build-essential curl file git

# Create a non-root user for Homebrew
RUN useradd -m -s /bin/bash linuxbrew && \
    usermod -aG sudo linuxbrew && \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew:linuxbrew /home/linuxbrew/.linuxbrew

# Switch to the non-root user
USER linuxbrew

# Set Homebrew environment variables
ENV HOME=/home/linuxbrew
ENV USER=linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH

# Install Homebrew
RUN git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew && \
    mkdir /home/linuxbrew/.linuxbrew/bin && \
    ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin && \
    brew config

# Install AWS CLI and Terraform using Homebrew
RUN brew install awscli terraform

# Set the working directory inside the Docker image
WORKDIR /app

# Copy package.json, package-lock.json, and other necessary files into the working directory
COPY findr_orchestrator/orchestrator/package*.json findr_orchestrator/orchestrator/tsconfig.json ./

# Copy the rest of the application source code
COPY findr_orchestrator/orchestrator/ ./

# Install Node.js dependencies
RUN npm install

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the app
CMD ["npm", "start"]
