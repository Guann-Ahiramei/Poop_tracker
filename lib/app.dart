import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tummytales/screens/main_screen.dart';


class TummyTalesApp extends StatelessWidget {
  const TummyTalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TummyTales',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFDF4E8),
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MainScreen(), // 👈 现在以主界面为入口
    );
  }
}
