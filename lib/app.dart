import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class PoopTrackerApp extends StatelessWidget {
  const PoopTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poop Tracker',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const HomeScreen(),
    );
  }
}
