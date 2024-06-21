const { Where } = require(`sequelize`);
const { Users } = require("../models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

class UserController {
  static register = async (req, res) => {
  try {
    const { username, password } = req.body;

    // Validasi input
    if (!username || !password) {
      return res.status(400).json({ message: "Username and password are required" });
    }

    // Cek apakah username sudah ada
    const existingUser = await Users.findOne({ where: { username } });
    if (existingUser) {
      return res.status(400).json({ message: "Username already exists" });
    }

    // Hash password sebelum disimpan
    const hashedPassword = await bcrypt.hash(password, 10);

    // Simpan pengguna baru
    const newUser = await Users.create({
      username,
      password: hashedPassword,
    });

    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    console.error("Error in register:", error);
    res.status(500).json({ message: "Failed to register user" });
  }
};


static login = async (req, res) => {
  try {
    const { username, password } = req.body;

    // Validasi input
    if (!username || !password) {
      return res.status(400).json({ message: "Username and password are required" });
    }

    // Cari pengguna berdasarkan username
    const user = await Users.findOne({ where: { username } });
    if (!user) {
      return res.status(400).json({ message: "Invalid username or password" });
    }

    // Bandingkan password yang di-hash dengan yang disimpan di database
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid username or password" });
    }

    // Buat token JWT
    const token = jwt.sign(
      { id: user.id, username: user.username }, // Include username in the payload
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Kirim token sebagai respon
    res.json({ token });
  } catch (error) {
    console.error("Error in login:", error);
    res.status(500).json({ message: "Failed to login user" });
  }
};

static async uploadImage(req, res) {
  try {
    const userId = req.params.id; // Ambil userId dari URL

    // Cari user berdasarkan ID
    const user = await Users.findByPk(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Update kolom image di tabel User
    user.image = req.file.path; // atau sesuaikan dengan cara Anda menyimpan informasi gambar

    await user.save();

    res.status(201).json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Internal server error' });
  }
}


}

module.exports = UserController;
