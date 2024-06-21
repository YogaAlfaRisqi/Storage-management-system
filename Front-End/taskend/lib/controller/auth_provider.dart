import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:taskend/constants/url.dart';

class AuthProvider with ChangeNotifier {
  final Dio _dio = Dio();
  final _baseUrl = AppUrl.baseUrl;

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _username;

  String? get username => _username;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    if (loginFormKey.currentState?.validate() ?? false) {
      try {
        final response = await _dio.post(
          '$_baseUrl/users/login',
          data: {
            'username': usernameController.text,
            'password': passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          final token = response.data['token'];
          await _saveToken(token);
          _username = _getUsernameFromToken(token);
          print('Username set to: $_username'); // Debug log
          notifyListeners();
          Navigator.pushReplacementNamed(context, '/menuNav');
        } else {
          throw Exception('Failed to login');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: $e')),
        );
      }
    }
  }

  Future<void> register(BuildContext context) async {
    if (registerFormKey.currentState?.validate() ?? false) {
      try {
        final response = await _dio.post(
          '$_baseUrl/users/register',
          data: {
            'username': usernameController.text,
            'password': passwordController.text,
          },
        );

        if (response.statusCode == 201) {
          await login(context);
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          throw Exception('Failed to register');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $e')),
        );
      }
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved: $token'); // Debug log
  }

  String? _getUsernameFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print('Decoded token: $decodedToken'); // Debug log
      return decodedToken[
          'username']; // Ensure this matches the token structure
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Token loaded: $token'); // Debug log
    if (token != null) {
      _username = _getUsernameFromToken(token);
      print('Username loaded: $_username'); // Debug log
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _username = null;
    notifyListeners();
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String> uploadImage(String userId, File imageFile) async {
    try {
      final String url = '$_baseUrl/upload/$userId';

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path,
            filename: (imageFile.path)),
      });

      Response response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            // 'Authorization': 'Bearer $yourToken', // Add JWT token if needed
          },
        ),
      );

      if (response.statusCode == 201) {
        return 'Image uploaded successfully';
      } else {
        return 'Failed to upload image';
      }
    } catch (error) {
      print('Error uploading image: $error');
      return 'Error uploading image: $error';
    }
  }
}
