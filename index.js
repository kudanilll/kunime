const express = require("express");
const cors = require("cors");
const route = require("./src/route");

const app = express();

app.use(cors());
app.use(route);

const port = 8000;
app.listen(port, () => {
  try {
    console.log(`Running on localhost:${port}`);
  } catch (error) {
    throw error;
  }
});