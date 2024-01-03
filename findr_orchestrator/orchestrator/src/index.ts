// index.ts

import express, { json } from 'express';
import { Orchestrator } from './orchestrator';

const app = express();
const port = 5000;
const orchestrator = new Orchestrator();

app.use(json());

app.post('/deploy', async (req, res) => {
  //try {
  const message = await orchestrator.deploy(req.body);
  res.send(message);
  //} 
  // catch (error: any) {
  //   console.error(`Error: ${error.message}`);
  //   res.status(500).send(`Error: ${error.message}`);
  // }
});

// Modified to listen on all network interfaces
app.listen(port, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${port}`);
});
