import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeProvider with ChangeNotifier {
  final List<Color> _containerColors = [
    Color(0xFFDAC0DF),
    Color(0xFFDBEBF0),
    Color(0xFF98D7C2),
    Color(0xFFF5B7B1),
  ];

  final List<IconData> _containerIcons = [
    Iconsax.home,
    Iconsax.category,
    Iconsax.box,
    Iconsax.user,
  ];

  final List<String> _containerTexts = [
    'Home',
    'Category',
    'Product',
    'Profile',
  ];

  List<Color> get containerColors => _containerColors;
  List<IconData> get containerIcons => _containerIcons;
  List<String> get containerTexts => _containerTexts;
}
