# Orchestrator

This repository contains a Node.js application written in TypeScript, designed to deploy resources to a Kubernetes cluster using Terraform. It provides an API endpoint to trigger Terraform configurations for deploying Kubernetes pods.

## Project Structure

- `src/`: Contains the TypeScript source code.
  - `index.ts`: The main Express server application.
  - `orchestrator.ts`: Class responsible for executing Terraform commands.
- `terraform/`: Holds Terraform configuration files for Kubernetes resource deployment.
- `Dockerfile`: Docker configuration for containerizing the Node.js application.
- `package.json`: Defines Node.js project dependencies.
- `tsconfig.json`: TypeScript compiler configuration.

## Prerequisites

- Node.js (v14 or later)
- Docker (for containerization)
- Terraform
- Access to a Kubernetes cluster

## Setup and Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/DISHDevEx/findr-orchestrator.git
   cd findr_orchestrator/orchestrator
   ```

2. **Install Node.js Dependencies**:

   ```bash
   npm install
   ```

3. **Configure Terraform**:

   - Navigate to the `terraform/` directory.
   - Update the Terraform configuration files with your Kubernetes cluster details.

4. **Build the TypeScript Project**:

   ```bash
   npm run build
   ```

5. **Running the Application**:

   - Locally:
     
     ```bash
     npm start
     ```

   - Using Docker:
     
     ```bash
     docker build -t orchestrator .
     docker run -p 3000:3000 orchestrator
     ```

6. **Accessing the API**:

   - The application runs on `http://localhost:3000`.
   - To deploy resources, make a POST request to `/deploy`.

## Usage

The application exposes a `/deploy` endpoint to trigger Terraform deployments. To deploy your Kubernetes resources:

```bash
curl -X POST http://localhost:3000/deploy -H "Authorization: Bearer YourSecretToken"
```