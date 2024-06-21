const { where } = require("sequelize");
const { Categories } = require("../models");

class CategoryController {
  static getAll = async (req, res) =>{
      try {
        const categories = await Categories.findAll();
        res.json(categories);
      } catch (err) {
        res.status(500).json({ message: err.message });
      }
    
  };

  static  getById = async(req,res)=>{
    const id = req.params.id;
    try {
      const categories = await Categories.findByPk(id);
      if (!categories) {
        return res.status(404).json({ message: 'Categories not found' });
      }
      res.json(categories);
    } catch (err) {
      res.status(500).json({ message: err.message });
  }
  }


  static add = async (req, res) =>{
    const {name} = req.body;
    try {
      const newCategories = await Categories.create({
        name,
        
      });
        res.status(201).json(newCategories);
    } catch (err) {
      res.status(400).json({ message: err.message });
  }


  }
  static update = async (req, res) => {
    const id = req.params.id;
    const { name } = req.body;
    try {
    const categories = await Categories.findByPk(id);
    if (!categories) {
      return res.status(404).json({ message: 'Categories not found' });
    }
    await categories.update({
      name,
    });
    res.json(categories);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
  }  
    


  
  static delete = async(req, res) =>{
    const id = req.params.id;
    try {
      const categories = await Categories.findByPk(id);
      if (!categories) {
        return res.status(404).json({ message: 'Categories not found' });
      }
      await categories.destroy();
      res.json({ message: 'Categories deleted successfully' });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
}

module.exports = CategoryController;
