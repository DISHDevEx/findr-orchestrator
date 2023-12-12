// index.ts

import express, { json } from 'express';
import { Orchestrator } from './orchestrator';

const app = express();
const port = 3000;
const orchestrator = new Orchestrator();

app.use(json());

app.post('/deploy', async (req, res) => {
  try {
    const message = await orchestrator.deploy(req.body);
    res.send(message);
  } catch (error: any) {
    console.error(`Error: ${error.message}`);
    res.status(500).send(`Error: ${error.message}`);
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
