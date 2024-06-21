import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskend/controller/auth_provider.dart';
import 'package:taskend/controller/category_provider.dart';
import 'package:taskend/controller/home_provider.dart';
import 'package:taskend/controller/navigation_provider.dart';
import 'package:taskend/controller/product_provider.dart';
import 'package:taskend/view/auth/login_screen.dart';
import 'package:taskend/view/auth/register_screen.dart';
import 'package:taskend/view/auth/welcome_screen.dart';
import 'package:taskend/view/features/category/category_screen.dart';
import 'package:taskend/view/features/home_screen.dart';
import 'package:taskend/view/features/products/product_screen.dart';
import 'package:taskend/view/features/profil/profile__screen.dart';
import 'package:taskend/widgets/navigation_menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadUser()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/register',
      routes: {
        '/menuNav': (context) => NavigationMenu(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(
              username: authProvider.username ?? 'Guest',
            ),
        '/category': (context) => CategoryScreen(),
        '/product': (context) => ProductScreen(),
        '/profil': (context) =>
            ProfileScreen(username: authProvider.username ?? 'Guest'),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}
