import 'package:dict_app/view/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
//import 'view/homescreen/homescreen.dart';

void main() {
  runApp(DictApp());
}

class DictApp extends StatelessWidget {
  const DictApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //home: HomeScreen(),
    );
  }
}
