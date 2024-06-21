const express = require('express');
const router = express.Router();
const { register, login, uploadImage } = require('../controllers/UserController');
const multer = require('multer');
const path = require('path');

// Konfigurasi multer untuk upload file
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
  }
});

const uploadConfig = multer({ storage: storage });

// Endpoint untuk upload gambar profil pengguna
router.post('/upload/:id', uploadConfig.single('image'), uploadImage);

router.post('/register', register);
router.post('/login', login);

module.exports = router;
