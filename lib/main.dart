import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tummytales/providers/goal_provider.dart';
import 'package:tummytales/providers/kitchen_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 匿名登录
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => KitchenProvider()),
      ],
      child: const TummyTalesApp(),
    ),
  );
}
