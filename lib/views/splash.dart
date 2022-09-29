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
      animationDuration: const Duration(seconds: 3), nextScreen: const HomeScreen(),

      // child: Scaffold(
      //   body: Container(
      //     color: const Color.fromARGB(255, 140, 3, 3),
      //     child: Center(
      //         child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Icon(
      //           Icons.place,
      //           size: 60.0,
      //           color: Colors.white,
      //         ),
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Restaurant App',
      //                 style: GoogleFonts.montserrat(
      //                     textStyle: const TextStyle(
      //                         color: Colors.white, fontSize: 24))),
      //             const Text('Aplikasi list restoran lokal',
      //                 style: TextStyle(color: Colors.white70, fontSize: 16))
      //           ],
      //         ),
      //       ],
      //     )),
      //   ),
      // ),
    );
  }
}
