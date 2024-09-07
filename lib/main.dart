// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hostelbuzz/splash_screen.dart';
import 'home_screen.dart';
import 'food_vote_screen.dart';
import 'review_screen.dart';
import 'maintenance_request_screen.dart';
import 'laundry_booking_screen.dart'; // Import LaundryBookingScreen
import 'laundry_status_screen.dart';  // Import LaundryStatusScreen
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://localhost:8090');

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
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/foodVote': (context) => FoodVoteScreen(),
        '/reviews': (context) => ReviewScreen(),
        '/maintenance': (context) => MaintenanceRequestScreen(),
        '/laundryBooking': (context) => LaundryBookingScreen(), // Add route for LaundryBookingScreen
        '/laundryStatus': (context) => LaundryStatusScreen(),    // Add route for LaundryStatusScreen
      },
    );
  }
}
