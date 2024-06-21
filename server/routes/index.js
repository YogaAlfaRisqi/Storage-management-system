const route = require(`express`).Router();

route.get(`/`, (req, res) => {
  res.json({
    message: "Home Page",
  });
});

const categoryRoutes = require(`./category`);
route.use(`/category`, categoryRoutes);

const productRoutes = require(`./products`);
route.use(`/products`, productRoutes);

const userRoutes = require(`./user`);
route.use(`/users`, userRoutes);

module.exports = route;
