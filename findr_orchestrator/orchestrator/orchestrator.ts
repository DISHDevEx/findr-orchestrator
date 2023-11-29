import express from 'express';
import bodyParser from 'body-parser';
import { writeFile } from 'fs/promises';
import { exec } from 'child_process';
import util from 'util';

const execAsync = util.promisify(exec);
const app = express();
app.use(bodyParser.json());

app.post('/deploy', async (req, res) => {
  try {
    const { terraformConfig } = req.body;

    await writeFile('./terraform/main.tf.json', JSON.stringify(terraformConfig));

    const { stdout, stderr } = await execAsync('terragrunt apply -auto-approve', { cwd: 'path/to/terragrunt/config' });
    if (stderr) {
      throw new Error(stderr);
    }

    res.json({ terragruntOutput: stdout });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
