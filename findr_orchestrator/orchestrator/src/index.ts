import express from 'express';
import { orchestrator } from './orchestrator';

/**
 * Initializes and configures the Express application.
 */
const app = express();
const port = 3000;

/**
 * POST endpoint to trigger Terraform deployment.
 */
app.post('/deploy', (req, res) => {
    const authHeader = req.headers.authorization;

    // Simple token-based authentication
    if (authHeader !== 'Bearer YourSecretToken') {
        return res.status(401).send('Unauthorized');
    }

    try {
        const configurationPath = '../k8s-resources';
        orchestrator.applyConfiguration(configurationPath);
        res.send('Terraform apply triggered');
    } catch (error) {
        res.status(500).send('Error triggering Terraform apply');
    }
});

// Start the Express server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
