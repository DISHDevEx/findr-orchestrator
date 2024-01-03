# Orchestrator

This documentation outlines a Node.js application written in TypeScript, designed to deploy resources to a Kubernetes cluster using Terraform. It provides an API endpoint to trigger Terraform configurations for deploying Kubernetes pods.

## Project Structure

- `src/`: Contains the TypeScript source code.
  - `index.ts`: The main Express server application.
  - `orchestrator.ts`: Class responsible for executing Terraform commands.
  - `k8s-resources/`: Holds Terraform configuration files for Kubernetes resource deployment.
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

3. **Build the TypeScript Project**:

   ```bash
   npm run build
   ```

4. **Running the Application**:

   - Locally:
     
     ```bash
     npm start
     ```

5. **Accessing the API**:

   - The application runs on `http://localhost:5000`.
   - To deploy resources, make a POST request to `/deploy`.

## Usage

The application exposes a `/deploy` endpoint to trigger Terraform deployments. To deploy your Kubernetes resources:

```bash
curl -kv -X POST -H "Content-Type: application/json" -H "Accept-Encoding: gzip, deflate, br" -H "Connection:keep-alive" -d '{
  "cluster_config": "kv/iot-findr-edge",
  "cluster_name": "iot-findr-edge",
  "connection_info": "kv/device-a-957fec50-566a-410f-8cc1-64b21b14e6b0",
  "namespace": "findr",
  "container_image": "docker.io/pravnreddy429/findr_adapters:v2",
  "aws_access_key_id": "",
  "aws_secret_access_key": "",
  "aws_session_token": ""
}' "http://localhost:5000/deploy"
```