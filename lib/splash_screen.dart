import 'dart:async';
import 'package:flutter/material.dart';

import 'Auth/login.dart';
// Import the LoginScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/DDU_2.png', width: 300),
            const SizedBox(height: 140),
            const Text(
              'Powered by',
              style: TextStyle(color: Colors.white),
            ),
            Image.asset('assets/logo.png', width: 150),
          ],
        ),
      ),
    );
  }
}
