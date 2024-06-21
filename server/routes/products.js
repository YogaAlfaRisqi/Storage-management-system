const productRoute = require(`express`).Router();
const ProductController = require(`../controllers/ProductController`);

productRoute.get(`/`, ProductController.getAll);
productRoute.get(`/:id`, ProductController.getById);
productRoute.post(`/add`, ProductController.add);
productRoute.put(`/update/:id`, ProductController.update);
productRoute.delete(`/delete/:id`, ProductController.delete);

module.exports = productRoute;
