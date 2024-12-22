const express = require("express");
const cors = require("cors");
const rateLimit = require("express-rate-limit");
const mongoose = require("mongoose");
const route = require("./src/route");
const config = require("./src/config");

const uri = config.MONGODB_URI;
const clientOptions = {
  // useNewUrlParser: true,
  // useUnifiedTopology: true,
  serverApi: {
    version: "1",
    strict: true,
    deprecationErrors: true,
  },
};

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // Limit requests per 15 minutes
  max: 50, // Allow maximum 50 requests per window
  message: {
    message: "Too many requests. Please try again later.",
  },
});

const app = express();

app.use(cors());
// Apply the limiter middleware to specific routes or globally
app.use(limiter);
app.use(route);

const port = process.env.PORT || 8000;
app.listen(port, () => {
  try {
    console.log(`Server running on 'http:localhost:${port}'`);
    mongoose
      .connect(uri, clientOptions)
      .then(() => console.log("MongoDB connected"))
      .catch((err) => console.error("MongoDB connection error:", err));
  } catch (error) {
    throw error;
  }
});
