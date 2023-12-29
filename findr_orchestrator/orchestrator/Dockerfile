# Use a base image that includes necessary utilities
FROM alpine:3.14 as tools

# Set Terraform and Helm versions
ENV TERRAFORM_VERSION=1.6.5

# Install Terraform & aws cli
RUN apk add --update wget unzip \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
    && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Stage 2: Setup the Node.js environment
# Specify the base image. Here, we're using Node 16. You can choose the version that matches your application's requirements.
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

# Grant full access to linuxbrew user
USER root
RUN chmod -R 777 /home/linuxbrew
USER linuxbrew

# Install Homebrew
RUN git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew && \
    mkdir /home/linuxbrew/.linuxbrew/bin && \
    ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin && \
    brew config

# Install AWS CLI using Homebrew
RUN brew install awscli

# Set the working directory inside the Docker image
WORKDIR /app

# Copy the package.json and package-lock.json files into our working directory
COPY findr_orchestrator/orchestrator/package*.json findr_orchestrator/orchestrator/tsconfig.json  ./

# Copy the rest of the application source code
COPY findr_orchestrator/orchestrator/ ./

# Copy Terraform from the tools stage
COPY --from=tools /usr/bin/terraform /usr/bin/terraform

# Install dependencies
RUN npm install

RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the app
CMD ["npm", "start"]"