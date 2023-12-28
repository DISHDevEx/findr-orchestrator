// orchestrator.ts

import { exec } from 'child_process';
import { writeFile } from 'fs/promises';
import dotenv from 'dotenv';

dotenv.config();

export class Orchestrator {
  private terraformPath = './src/k8s-resources/';
  async deploy(params: any): Promise<string> {
    
    const tfVars = {
      vault_address: process.env.VAULT_ADDRESS,
      vault_token: process.env.VAULT_TOKEN,
      cluster_config: params.cluster_config,
      cluster_name: params.cluster_name,
      connection_info: params.connection_info,
      namespace: params.namespace,
      container_image: params.container_image
    };

    await this.createTfVarsFile(tfVars);

    return new Promise((resolve, reject) => {
      exec('aws eks --region us-east-1 update-kubeconfig --name iot-findr-edge \
      && terraform init \
      && TF_LOG=DEBUG terraform apply -auto-approve', { cwd: this.terraformPath }, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          reject(error);
        } else {
          console.log(`stdout: ${stdout}`);
          console.error(`stderr: ${stderr}`);
          resolve('Deployment initiated.');
        }
      });
    });
  }

  private async createTfVarsFile(tfVars: any): Promise<void> {
    try {
      await writeFile(`${this.terraformPath}/terraform.tfvars.json`, JSON.stringify(tfVars, null, 2));
    } catch (error) {
      console.error(`File write error: ${error}`);
      throw error;
    }
  }
}
