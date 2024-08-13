import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'food_vote_screen.dart';
import 'review_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelBuzz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/foodVote': (context) => FoodVoteScreen(),
        '/reviews': (context) => ReviewScreen(),
      },
    );
  }
}
