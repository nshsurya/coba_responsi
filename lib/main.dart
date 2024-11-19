import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/favorites_page.dart';
import 'providers/favorite_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/favorites': (context) => FavoritesPage(),
      },
    );
  }
}
