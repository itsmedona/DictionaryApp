import 'package:flutter/material.dart';

import 'homescreen/homescreen.dart';

void main() {
  runApp(DictApp());
}

class DictApp extends StatelessWidget {
  const DictApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
