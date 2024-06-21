import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskend/controller/auth_provider.dart';
import 'package:taskend/controller/navigation_provider.dart';
import 'package:taskend/view/features/category/category_screen.dart';
import 'package:taskend/view/features/home_screen.dart';
import 'package:taskend/view/features/products/product_screen.dart';
import 'package:taskend/view/features/profil/profile__screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Widget> _screens = [
      HomeScreen(username: authProvider.username ?? 'Guest'),
      CategoryScreen(),
      ProductScreen(),
      ProfileScreen(username: authProvider.username ?? 'Guest'),
    ];

    return Scaffold(
      body: PageView(
        controller: navigationProvider.pageController,
        onPageChanged: (index) {
          navigationProvider.onPageChanged(index);
        },
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: navigationProvider.selectedIndex,
        onDestinationSelected: (index) {
          navigationProvider.setIndex(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.category), label: 'Category'),
          NavigationDestination(icon: Icon(Iconsax.box), label: 'Product'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
