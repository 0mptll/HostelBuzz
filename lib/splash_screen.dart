import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostelbuzz/main.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<SplashScreen> createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    Timer(Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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
            Image.asset('assets/logo.png', width: 300),
            SizedBox(height: 140),
            Text(
              'Powered by',
              style: TextStyle(color: Colors.white),
            ),
            // Replace 'assets/images/powered_by_logo.png' with your actual logo path
            Image.asset('assets/logo.png', width: 150),
          ],
        ),
      ),
    );
  }



}
