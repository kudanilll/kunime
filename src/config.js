require("dotenv").config();

const config = {
  MONGODB_URI: process.env.MONGODB_URI,
  BASE_URL: process.env.BASE_URL,
  API_KEY: process.env.API_KEY,
  COOKIE: process.env.COOKIE,
  USER_AGENT: process.env.USER_AGENT,
  X_REQUEST_WITH: process.env.X_REQUEST_WITH,
  CONTENT_TYPE: process.env.CONTENT_TYPE,
};

module.exports = config;
