import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_json/datamodel/restaurant.dart';
import 'package:restaurant_dicoding_json/views/menu_resto.dart';
import 'package:restaurant_dicoding_json/views/splash.dart';
import 'package:restaurant_dicoding_json/views/detail_resto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 140, 3, 3),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/menu_resto': (context) => const HomeScreen(),
        '/detailresto': (context) => DetailResto(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}
