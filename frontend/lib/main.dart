import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const FinGuardAI());
}

class FinGuardAI extends StatelessWidget {
  const FinGuardAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "FinGuard AI",

      theme: ThemeData(
        useMaterial3: true,
      ),

      home: const LoginScreen(),
    );
  }
}