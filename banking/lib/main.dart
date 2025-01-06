import 'package:banking/Screen/GetStart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.setLanguageCode("en");
  runApp(BankingApp());
}

class BankingApp extends StatefulWidget {
  const BankingApp({super.key});

  @override
  _BankingAppState createState() => _BankingAppState();
}

class _BankingAppState extends State<BankingApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: GetStartScreen(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}