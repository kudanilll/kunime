const config = require("./config");

const key = config.API_KEY;

const secure = (req, res, next) => {
  if (req.headers["x-api-key"] !== key) {
    return res.status(401).json({ success: false, message: "Unauthorized" });
  }
  next();
};

module.exports = secure;
