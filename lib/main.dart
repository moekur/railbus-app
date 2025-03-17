import 'package:flutter/material.dart';
import 'ui/screens/shareholder_home_page.dart';
import 'package:railbus/ui/screens/auth_screen.dart';

void main() {
  runApp(const RailbusApp());
}

class RailbusApp extends StatelessWidget {
  const RailbusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAILBUS Shareholders',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          primary: const Color.fromARGB(255, 0, 0, 0),
          secondary: const Color(0xFFD4AF37),
          background: Colors.grey[100]!,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A3C6D),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}