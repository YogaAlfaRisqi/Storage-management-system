import 'package:flutter/material.dart';
import 'package:taskend/view/features/profil/components/profile_menu.dart';
import 'package:taskend/view/features/profil/components/profile_pic.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for shared preferences

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  final String username; // Username parameter

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  // Method to handle logout
  Future<void> _handleLogout(BuildContext context) async {
    // Remove token or clear user session
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'token'); // Replace 'token' with your actual key used for token storage

    // Navigate back to login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(
              key: null,
            ),
            const SizedBox(height: 20),
            Text(
              '$username',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () => _handleLogout(context), // Logout action
            ),
          ],
        ),
      ),
    );
  }
}
