import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_json/views/menu_resto.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextRoute: '/menu_resto',
      splash: const Icon(
        Icons.place,
        size: 60.0,
        color: Colors.white,
      ),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Theme.of(context).primaryColor,
      animationDuration: const Duration(seconds: 3),
      nextScreen: const HomeScreen(),
    );
  }
}
