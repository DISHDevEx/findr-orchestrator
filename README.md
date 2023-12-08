# FINDR Orchestrator

## Introduction

This repository holds our comprehensive solution to deploy essential cloud infrastructure and services swiftly, making FINDR fully operational in minutes. This setup encompasses a suite of integral components:

- **Apollo**:
- **Harbor**: An advanced open-source registry securing artifacts with policies and role-based access control. It ensures that images are scanned and free from vulnerabilities.
- **Monitoring**: A robust In-House Monitoring and Management Stack.
- **Oracle**:
- **Orchestrator**: API endpoint to trigger Terraform configurations for deploying Kubernetes pods at the edge
- **Vault**: Specialized in secure access to secrets, Vault adeptly manages tokens, passwords, certificates, API keys, and other essential secrets.
- **FINDR User Interface**: 

Together, these components form a cohesive and secure ecosystem for FINDR.

## Prerequisites

Before starting, ensure you have the following prerequisites installed and configured:
- Git
- Terraform
- Terragrunt
- AWS CLI
- Node.js
- NPM

With these prerequisites in place, you are all set to initialize and deploy FINDR.

### Subdirectories Overview

- **[Infrastructure](./findr_orchestrator/infrastructure/README.md)**: Contains Terraform scripts for infrastructure setup.
- **[Orchestrator](./findr_orchestrator/orchestrator/README.md)**: Contains the source code for the Orchestrator service.

For in-depth details on each component, refer to the README files within their respective directories.