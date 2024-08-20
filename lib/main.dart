// lib/main.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'food_vote_screen.dart';
import 'review_screen.dart';
import 'maintenance_request_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HostelBuzz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/foodVote': (context) => FoodVoteScreen(),
        '/reviews': (context) => ReviewScreen(),
        '/maintenance': (context) => MaintenanceRequestScreen(),
      },
    );
  }
}
