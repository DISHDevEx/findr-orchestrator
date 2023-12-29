# Stage 1: Install Terraform and Helm
# Use a base image that includes necessary utilities
FROM alpine:3.14 as tools

# Set Terraform version
ENV TERRAFORM_VERSION=1.6.5

# Install Terraform
RUN apk add --update wget unzip \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
    && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Stage 2: Setup the Node.js environment
# Specify the base image. Here, we're using Node 16.
FROM node:16

# Install dependencies for Homebrew
RUN apt-get update && apt-get install -y build-essential curl file git

# Create directories for Homebrew
RUN mkdir -p /home/linuxbrew/.linuxbrew/Homebrew /home/linuxbrew/.linuxbrew/bin

# Install Homebrew
RUN git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew \
    && ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin \
    && /home/linuxbrew/.linuxbrew/bin/brew update --force --quiet \
    && chmod -R 755 /home/linuxbrew/.linuxbrew

# Set Homebrew environment variables
ENV PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

# Install AWS CLI and Terraform using Homebrew
RUN brew install awscli \
    && brew install terraform

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
CMD ["npm", "start"]