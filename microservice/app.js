const express = require("express");
const app = express();

app.get("/health", (req, res) => {
  res.json({
    status: "OK",
    service: "microservice",
    message: "Microservice running locally (later EKS) 🚀"
  });
});

app.listen(4000, () => {
  console.log("Microservice started on port 4000");
});

