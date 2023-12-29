// orchestrator.ts
import { exec } from 'child_process';
import { writeFile} from 'fs/promises';
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

    try {
      await this.createTfVarsFile(tfVars);
    } catch (error) {
      console.error(`Error in deployment process: ${error}`);
      throw error;
    }

    return new Promise((resolve, reject) => {
      const command = 'terraform init && TF_LOG=DEBUG terraform apply -auto-approve';
      const options = {
          cwd: this.terraformPath,
          env: {
              ...process.env, // Include all existing environment variables
              'AWS_ACCESS_KEY_ID': process.env.AWS_ACCESS_KEY_ID,
              'AWS_SECRET_ACCESS_KEY': process.env.AWS_SECRET_ACCESS_KEY,
              'AWS_SESSION_TOKEN': process.env.AWS_SESSION_TOKEN
          }
      };
  
      exec(command, options, (error, stdout, stderr) => {
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
      await writeFile(`${this.terraformPath}terraform.tfvars.json`, JSON.stringify(tfVars, null, 2));
    } catch (error) {
      console.error(`File write error: ${error}`);
      throw error;
    }
  }
}
