import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class PoopTrackerApp extends StatelessWidget {
  const PoopTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poop Tracker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textTheme:
        GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
        // const TextTheme(
        //   bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
      ),
      home: const HomeScreen(),
    );
  }
}
