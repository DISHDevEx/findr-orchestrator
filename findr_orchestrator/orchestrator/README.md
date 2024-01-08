
# Orchestrator

Welcome to the Orchestrator documentation. This Node.js application, written in TypeScript, is crafted to streamline the deployment of resources to a Kubernetes cluster using Terraform. It features an API endpoint for initiating Terraform configurations to deploy Kubernetes pods effectively.

## Project Structure

- **`src/`**: The heart of the application, containing TypeScript source code.
  - `index.ts`: Entry point of the application, establishing the Express server.
  - `orchestrator.ts`: Core class that manages the execution of Terraform commands.
  - `k8s-resources/`: Dedicated directory housing the Terraform configurations for Kubernetes resource deployment. Includes files like `main.tf`, `outputs.tf`, variables declarations, and state files.
- **`Dockerfile`**: Configuration for dockerizing the Node.js application, facilitating containerization.
- **`package.json` & `package-lock.json`**: Node.js project dependencies and their locked versions, ensuring consistent installations.
- **`tsconfig.json`**: Settings for the TypeScript compiler, outlining how the TypeScript code is compiled to JavaScript.
- **`terraform.tfstate`**: The Terraform state file at the project root, tracking the state of your Terraform-managed infrastructure.

## Prerequisites

To get started, ensure you have:
- Node.js (version 14 or later)
- Docker (for application containerization)
- Terraform
- Access to a Kubernetes cluster

## Setup and Installation

Follow these steps to set up the Orchestrator:

1. **Clone the Repository**:
   Clone this repository to your local machine using:
   ```bash
   git clone https://github.com/DISHDevEx/findr-orchestrator.git
   cd findr_orchestrator/orchestrator
   ```

2. **Install Node.js Dependencies**:
   Install all the necessary Node.js dependencies by running:
   ```bash
   npm install
   ```

3. **Build the TypeScript Project**:
   Compile the TypeScript code with:
   ```bash
   npm run build
   ```

4. **Running the Application**:
   To run the application locally, execute:
   ```bash
   npm start
   ```

5. **Accessing the API**:
   The application will be accessible at `http://localhost:5000`. Deploy resources by making a POST request to the `/deploy` endpoint.

## Usage

Deploy Kubernetes resources via the application's `/deploy` endpoint using the following command:
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

---

This documentation provides a comprehensive guide to setting up and using the Orchestrator for efficient Kubernetes resource management.
