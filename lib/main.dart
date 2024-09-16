// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hostelbuzz/Auth/AuthPage.dart';
import 'package:hostelbuzz/Auth/TempLoginScreen.dart';
import 'package:hostelbuzz/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'food_vote_screen.dart';
import 'review_screen.dart';
import 'maintenance_request_screen.dart';
import 'laundry_booking_screen.dart'; // Import LaundryBookingScreen
import 'laundry_status_screen.dart';  // Import LaundryStatusScreen
import 'Auth/LoginScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

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
        // '/login': (context) => TempLoginScreen(),
        '/login' : (context) => LoginScreen(),
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
