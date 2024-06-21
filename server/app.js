const express = require(`express`);
require('dotenv').config();

const bodyParser = require("body-parser");
const app = express();
const port = 3000;
const { sequelize } = require("./models");

app.use(express.json());
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

const routes = require(`./routes`);
app.use(routes);

const PORT = process.env.PORT || 3000;
app.listen(port, async () => {
  await sequelize.authenticate();
  console.log(`Server running on http://localhost:${port}`);
});
//
