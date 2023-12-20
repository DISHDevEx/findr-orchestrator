// orchestrator.ts

import { exec } from 'child_process';
import { writeFile } from 'fs/promises';
import axios from 'axios';


export class Orchestrator {
  private terraformPath = './src/k8s-resources/';
  async deploy(params: any): Promise<string> {
    
    const tfVars = {
      vault_address:params.vault_address,
      vault_token:params.vault_token,
      cluster_config: params.cluster_config,
      cluster_name: params.cluster_name,
      connection_info: params.connection_info,
      namespace: params.namespace,
      container_image: params.container_image
    };

    await this.createTfVarsFile(tfVars);

    return new Promise((resolve, reject) => {
      exec('terraform init && terraform plan && TF_LOG=DEBUG terraform apply -auto-approve', { cwd: this.terraformPath }, (error, stdout, stderr) => {
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
