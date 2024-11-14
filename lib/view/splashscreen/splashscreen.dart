import 'dart:async';
import 'package:dict_app/view/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred image
          Image.asset(
            'assets/images/dict_app.jpg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          // Column for Text and Image content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text above the image
                Text(
                  'Dicto App',
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
