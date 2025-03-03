import express from "express";

const app = express();
app.use(express.json());
app.use("/health", (req, res) => {
  res.status(200).send("OK"); // Respond with a status code of 200 and 'OK'
});

app.get("/user", async (req, res) => {
  res.send({
    name: "Jane Doe",
    age: 25,
  });
});

app.listen(3000);
