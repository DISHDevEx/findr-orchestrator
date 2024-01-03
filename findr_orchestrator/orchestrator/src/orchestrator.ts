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
      const command = `export AWS_ACCESS_KEY_ID='${params.aws_access_key_id}' 
                       export AWS_SECRET_ACCESS_KEY='${params.aws_secret_access_key}'  
                       export AWS_SESSION_TOKEN='${params.aws_session_token}'
                       terraform init && TF_LOG=DEBUG terraform apply -auto-approve && rm -rf terraform.tfstate`;
      console.log(command);
          
      exec(command, { cwd: this.terraformPath }, (error, stdout, stderr) => {
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
