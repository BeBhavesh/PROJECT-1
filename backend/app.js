const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("✅ Backend running locally (later ECS) 🚀");
});

app.get("/health", (req, res) => {
  res.json({ status: "OK", service: "backend" });
});

app.listen(3000, () => {
  console.log("Backend started on port 3000");
});

