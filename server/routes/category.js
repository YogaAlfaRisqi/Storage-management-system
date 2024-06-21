const categoryRoute = require(`express`).Router();
const CategoryController = require(`../controllers/CategoryController`);

categoryRoute.get(`/`, CategoryController.getAll);
categoryRoute.get(`/:id`, CategoryController.getById);
categoryRoute.post(`/add`, CategoryController.add);
categoryRoute.put(`/update/:id`, CategoryController.update);
categoryRoute.delete(`/delete/:id`, CategoryController.delete);

module.exports = categoryRoute;
