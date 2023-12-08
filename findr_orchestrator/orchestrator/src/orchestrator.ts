import { execSync } from 'child_process';

/**
 * A class responsible for executing Terraform commands.
 */
export class orchestrator {
    /**
     * Runs `terraform apply` command for a given configuration path.
     * @param configurationPath The file path to Terraform configuration.
     * @returns Output from the Terraform command execution.
     */
    static applyConfiguration(configurationPath: string): string {
        try {
            const output = execSync(`terraform apply -auto-approve -input=false ${configurationPath}`, { encoding: 'utf-8', stdio: 'inherit' });
            return output;
        } catch (error) {
            console.error('Error executing Terraform:', error);
            throw error;
        }
    }
}
