
const express = require('express');
const app = express();


const ENVIRONMENT = process.env.ENVIRONMENT || "production";

app.get('/', (req, res) => {
   res.send(`Environment: ${ENVIRONMENT}`);
});


const PORT = process.env.PORT || 80;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
