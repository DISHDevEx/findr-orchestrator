import { exec } from 'child_process';
import { writeFile, access, chmod } from 'fs/promises';
import { constants } from 'fs';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

export class Orchestrator {
  private terraformPath = path.join(__dirname, 'src', 'k8s-resources');

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
      await this.checkAndSetWriteAccess(this.terraformPath);
      await this.createTfVarsFile(tfVars);
    } catch (error) {
      console.error(`Error in deployment process: ${error}`);
      throw error;
    }

    return new Promise((resolve, reject) => {
      exec('terraform init && TF_LOG=DEBUG terraform apply -auto-approve', { cwd: this.terraformPath }, (error, stdout, stderr) => {
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
    const filePath = path.join(this.terraformPath, 'terraform.tfvars.json');
    await writeFile(filePath, JSON.stringify(tfVars, null, 2));
    await this.setWriteAccess(filePath);
  }

  private async checkAndSetWriteAccess(directory: string): Promise<void> {
    try {
      await access(directory, constants.W_OK);
    } catch {
      console.log(`Setting write permission for the directory: ${directory}`);
      await this.setWriteAccess(directory);
    }
  }

  private async setWriteAccess(filePath: string): Promise<void> {
    try {
      // 0o666 sets read and write permissions for owner, group and others
      await chmod(filePath, 0o666);
    } catch (error) {
      throw new Error(`Failed to set write access for ${filePath}: ${error}`);
    }
  }
}
