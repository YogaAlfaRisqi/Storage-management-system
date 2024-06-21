const { where } = require("sequelize");
const { Products } = require("../models");


class ProductController {
  static getAll = async(req, res) =>{
    try {
      const product = await Products.findAll();
      res.json(product);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static getById =async(req,res)=>{
    const id = req.params.id;
    try {
    const product = await Products.findByPk(id);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.json(product);
    }catch (err) {
    res.status(500).json({ message: err.message });
  }
  }

  static add = async(req, res) =>{
    const { name, qty, categoryId, url, createDate, updateDate, createdBy, updatedBy } = req.body;
    try {
    const newProduct = await Products.create({
      name,
      qty,
      categoryId,
      url,
      createDate,
      updateDate,
      createdBy,
      updatedBy
    });
    res.status(201).json(newProduct);
    } catch (err) {
    res.status(400).json({ message: err.message });
    }
  }

  static update = async(req, res) =>{
    const id = req.params.id;
    const { name, qty, categoryId, url, updateDate, updatedBy } = req.body;
    try {
    const product = await Products.findByPk(id);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }
    await product.update({
      name,
      qty,
      categoryId,
      url,
      updateDate,
      updatedBy
    });
    res.json(product);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }


  }
  static delete =  async(req, res) =>{
    const id = req.params.id;
    try {
      const product = await Products.findByPk(id);
      if (!product) {
        return res.status(404).json({ message: 'Product not found' });
      }
      await product.destroy();
      res.json({ message: 'Product deleted successfully' });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
}

module.exports = ProductController;
