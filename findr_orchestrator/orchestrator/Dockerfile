# Stage 1: Install Terraform and Helm
# Use a base image that includes necessary utilities
FROM alpine:3.14 as tools

# Set Terraform and Helm versions
ENV TERRAFORM_VERSION=1.6.5
ENV HELM_VERSION=3.7.1

# Install Terraform
RUN apk add --update wget unzip \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
    && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Helm
RUN wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/bin/helm \
    && rm -rf linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz

# Stage 2: Setup the Node.js environment
# Specify the base image. Here, we're using Node 16. You can choose the version that matches your application's requirements.
FROM node:16

# Set the working directory inside the Docker image
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files into our working directory
COPY package*.json ./

# Install dependencies
RUN npm install

RUN npm run build

# Copy the rest of the application source code
COPY . .

# Copy Terraform and Helm from the tools stage
COPY --from=tools /usr/bin/terraform /usr/bin/terraform
COPY --from=tools /usr/bin/helm /usr/bin/helm

# Your application might use a build step, uncomment this if necessary
# RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the app

CMD ["npm" "start"]